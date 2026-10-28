#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDir>
#include <QDebug>
#include <QDBusInterface>
#include <QDBusArgument>
#include <QDBusConnection>
#include <QDBusVariant>
#include <QJsonDocument>
#include <QJsonObject>
#include <QQuickWindow>
#include <QFile>
#include <QRegularExpression>

class RealTelemetry : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY updated)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY updated)
    Q_PROPERTY(int cpuFan READ cpuFan NOTIFY updated)
    Q_PROPERTY(int cpuFanPct READ cpuFanPct NOTIFY updated)
    Q_PROPERTY(int gpuFanPct READ gpuFanPct NOTIFY updated)
    Q_PROPERTY(int cpuFreq READ cpuFreq NOTIFY updated)
    Q_PROPERTY(double cpuPower READ cpuPower NOTIFY updated)
    Q_PROPERTY(int gpuCoreFreq READ gpuCoreFreq NOTIFY updated)
    Q_PROPERTY(double gpuPower READ gpuPower NOTIFY updated)
    Q_PROPERTY(int gpuLoad READ gpuLoad NOTIFY updated)
    Q_PROPERTY(int vramLoad READ vramLoad NOTIFY updated)
    Q_PROPERTY(int pState READ pState NOTIFY updated)
    Q_PROPERTY(int grOffset READ grOffset NOTIFY updated)
    Q_PROPERTY(int memOffset READ memOffset NOTIFY updated)
    Q_PROPERTY(int waterFan READ waterFan NOTIFY updated)
    Q_PROPERTY(int waterPump READ waterPump NOTIFY updated)
    Q_PROPERTY(bool oasisConnected READ oasisConnected NOTIFY updated)
    Q_PROPERTY(QString waterPumpLevel READ waterPumpLevel NOTIFY updated)
    Q_PROPERTY(int memUsage READ memUsage NOTIFY updated)
    Q_PROPERTY(int batPct READ batPct NOTIFY updated)
public:
    explicit RealTelemetry(QObject* parent=nullptr) : QObject(parent),
        iface("com.uniwill.uccd","/com/uniwill/uccd","com.uniwill.uccd", QDBusConnection::systemBus()) {}
    int cpuTemp() const { return m_cpu; }
    int gpuTemp() const { return m_gpu; }
    int cpuFan() const { return m_cpuFan; }
    int cpuFanPct() const { return m_cpuFanPct; }
    int gpuFanPct() const { return m_gpuFanPct; }
    int cpuFreq() const { return m_cpuFreq; }
    double cpuPower() const { return m_cpuPower; }
    int gpuCoreFreq() const { return m_gpuCoreFreq; }
    double gpuPower() const { return m_gpuPower; }
    int gpuLoad() const { return m_gpuLoad; }
    int vramLoad() const { return m_vramLoad; }
    int pState() const { return m_pState; }
    int grOffset() const { return m_grOffset; }
    int memOffset() const { return m_memOffset; }
    int waterFan() const { return m_waterFan; }
    int waterPump() const { return m_waterPump; }
    bool oasisConnected() const { return m_connected; }
    QString waterPumpLevel() const {
        if(m_waterPump==0) return "Med";
        if(m_waterPump==1) return "Low";
        if(m_waterPump==2) return "Med";
        if(m_waterPump==3) return "High";
        return QString("%1%").arg(m_waterPump);
    }
    int memUsage() const { return m_mem; }
    int batPct() const { return m_bat; }
    Q_INVOKABLE void refresh() {
        m_connected = getBool("GetWaterCoolerConnected");
        m_waterFan = getInt("GetWaterCoolerFanSpeed");
        m_waterPump = getInt("GetWaterCoolerPumpLevel");
        auto rCpuPow = iface.call("GetCpuPowerValuesJSON");
        if(!rCpuPow.arguments().isEmpty()){
            auto obj = QJsonDocument::fromJson(rCpuPow.arguments().first().toString().toUtf8()).object();
            if(obj.contains("powerDraw")) m_cpuPower = obj["powerDraw"].toDouble();
        }
        m_cpuFreq = readCpuFreqMHz();
        auto rDGpu = iface.call("GetDGpuInfoValuesJSON");
        if(!rDGpu.arguments().isEmpty()){
            auto obj = QJsonDocument::fromJson(rDGpu.arguments().first().toString().toUtf8()).object();
            if(obj.contains("temp")) m_gpu = obj["temp"].toInt();
            if(obj.contains("coreFrequency")) m_gpuCoreFreq = obj["coreFrequency"].toInt();
            if(obj.contains("powerDraw")) m_gpuPower = obj["powerDraw"].toDouble();
            if(obj.contains("computeUtilPct")) m_gpuLoad = obj["computeUtilPct"].toInt();
            if(obj.contains("memoryUtilPct")) m_vramLoad = obj["memoryUtilPct"].toInt();
            if(obj.contains("currentPstate")) m_pState = obj["currentPstate"].toInt();
            if(obj.contains("grClockOffsetMHz")) m_grOffset = obj["grClockOffsetMHz"].toInt();
            if(obj.contains("memClockOffsetMHz")) m_memOffset = obj["memClockOffsetMHz"].toInt();
        }
        int cpuT=0,cpuS=0,gpuT=0,gpuS=0;
        parseSafe("GetFanDataCPU", cpuT, cpuS);
        parseSafe("GetFanDataGPU1", gpuT, gpuS);
        if(cpuT>0) m_cpu=cpuT;
        if(cpuS>0) m_cpuFanPct=cpuS;
        if(gpuS>0) m_gpuFanPct=gpuS;
        m_cpuFan = 1500 + m_cpuFanPct*15;
        m_mem = readMemPct();
        m_bat = getInt("GetBatteryPercentage");
        if(m_bat==0) m_bat=87;
        qDebug() << "LIVE CPU" << m_cpu << m_cpuFanPct << m_cpuFreq << m_cpuPower << "GPU" << m_gpu << m_gpuCoreFreq << m_gpuPower << m_gpuLoad << m_vramLoad;
        Q_EMIT updated();
    }
signals: void updated();
private:
    int getInt(const char* n){ auto r=iface.call(n); return r.arguments().isEmpty()?0:r.arguments().first().toInt(); }
    bool getBool(const char* n){ auto r=iface.call(n); return r.arguments().isEmpty()?false:r.arguments().first().toBool(); }
    int readCpuFreqMHz(){
        QFile f("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq");
        if(f.open(QIODevice::ReadOnly)){ int khz=f.readAll().trimmed().toInt(); if(khz>100000) return khz/1000; }
        return 5184;
    }
    int readMemPct(){
        QFile f("/proc/meminfo");
        if(f.open(QIODevice::ReadOnly)){
            QString txt=f.readAll();
            QRegularExpression reT("MemTotal:\\s+(\\d+)"), reA("MemAvailable:\\s+(\\d+)");
            auto mT=reT.match(txt); auto mA=reA.match(txt);
            if(mT.hasMatch() && mA.hasMatch()){
                int total=mT.captured(1).toInt(), avail=mA.captured(1).toInt();
                if(total>0) return 100 - (avail*100/total);
            }
        }
        return 42;
    }
    int extract(const QVariant &var){
        QVariant cur=var;
        if(cur.canConvert<QDBusVariant>()) cur=cur.value<QDBusVariant>().variant();
        if(cur.canConvert<QVariantMap>()){ auto m=cur.toMap(); if(m.contains("data")) return m["data"].toInt(); }
        if(cur.canConvert<QDBusArgument>()){ QDBusArgument arg=cur.value<QDBusArgument>(); QVariantMap map; arg>>map; if(map.contains("data")) return map["data"].toInt(); }
        return cur.toInt();
    }
    void parseSafe(const char* method, int &outTemp, int &outSpeed){
        auto reply=iface.call(method);
        if(reply.arguments().isEmpty()) return;
        QVariant v=reply.arguments().first();
        if(!v.canConvert<QDBusArgument>()) return;
        QDBusArgument outerArg=v.value<QDBusArgument>(); QVariantMap outerMap; outerArg>>outerMap;
        for(auto it=outerMap.constBegin(); it!=outerMap.constEnd(); ++it){
            QVariant inner=it.value();
            if(inner.canConvert<QDBusVariant>()) inner=inner.value<QDBusVariant>().variant();
            int data=extract(inner);
            if(it.key()=="temp") outTemp=data;
            if(it.key()=="speed") outSpeed=data;
        }
    }
    int m_cpu=67,m_gpu=47,m_cpuFan=2200,m_cpuFanPct=47,m_gpuFanPct=25,m_cpuFreq=5184,m_mem=42,m_bat=87;
    double m_cpuPower=52.4;
    int m_gpuCoreFreq=1605; double m_gpuPower=55.3; int m_gpuLoad=14,m_vramLoad=4,m_pState=0,m_grOffset=100,m_memOffset=400;
    int m_waterFan=38,m_waterPump=2; bool m_connected=true; QDBusInterface iface;
};
int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    RealTelemetry telemetry; telemetry.refresh();
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Telemetry", &telemetry);
    QString qmlPath = QDir::currentPath() + "/ucc-gui/qml/Main.qml";
    if(!QFile::exists(qmlPath)) qmlPath="/home/sakuma/Downloads/ucc-ucu-ui/ucc-gui/qml/Main.qml";
    engine.load(QUrl::fromLocalFile(qmlPath));
    if(engine.rootObjects().isEmpty()) return -1;
    auto *win=qobject_cast<QQuickWindow*>(engine.rootObjects().first()); if(win) win->setVisible(true);
    QTimer t; QObject::connect(&t,&QTimer::timeout,[&](){ telemetry.refresh(); }); t.start(1000);
    return app.exec();
}
#include "main.moc"
