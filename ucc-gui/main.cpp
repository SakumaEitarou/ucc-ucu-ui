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

class RealTelemetry : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY updated)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY updated)
    Q_PROPERTY(int cpuFan READ cpuFan NOTIFY updated)
    Q_PROPERTY(int cpuFanPct READ cpuFanPct NOTIFY updated)
    Q_PROPERTY(int waterFan READ waterFan NOTIFY updated)
    Q_PROPERTY(int waterPump READ waterPump NOTIFY updated)
    Q_PROPERTY(bool oasisConnected READ oasisConnected NOTIFY updated)
    Q_PROPERTY(QString oasisStatus READ oasisStatus NOTIFY updated)
public:
    explicit RealTelemetry(QObject* parent=nullptr) : QObject(parent),
        iface("com.uniwill.uccd","/com/uniwill/uccd","com.uniwill.uccd", QDBusConnection::systemBus()) {}
    int cpuTemp() const { return m_cpu; }
    int gpuTemp() const { return m_gpu; }
    int cpuFan() const { return m_cpuFan; }
    int cpuFanPct() const { return m_cpuFanPct; }
    int waterFan() const { return m_waterFan; }
    int waterPump() const { return m_waterPump; }
    bool oasisConnected() const { return m_connected; }
    QString oasisStatus() const { return QString("Mk2-V4 %1 RPM / Pump %2%").arg(m_waterFan).arg(m_waterPump); }
    Q_INVOKABLE void refresh() {
        m_connected = getBool("GetWaterCoolerConnected");
        m_waterFan = getInt("GetWaterCoolerFanSpeed");
        m_waterPump = getInt("GetWaterCoolerPumpLevel");
        auto rDGpu = iface.call("GetDGpuInfoValuesJSON");
        if(!rDGpu.arguments().isEmpty()){
            auto obj = QJsonDocument::fromJson(rDGpu.arguments().first().toString().toUtf8()).object();
            if(obj.contains("temp")) m_gpu = obj["temp"].toInt();
        }
        int cpuT=0,cpuS=0,gpuT=0,gpuS=0;
        parseSafe("GetFanDataCPU", cpuT, cpuS);
        parseSafe("GetFanDataGPU1", gpuT, gpuS);
        qDebug() << "PARSED CPU" << cpuT << cpuS << "GPU" << gpuT << gpuS;
        if(cpuT>0) m_cpu=cpuT;
        if(cpuS>0) m_cpuFanPct=cpuS;
        if(gpuT>0) m_gpu=gpuT;
        m_cpuFan = 1500 + m_cpuFanPct*15;
        Q_EMIT updated();
    }
signals: void updated();
private:
    int getInt(const char* n){ auto r=iface.call(n); return r.arguments().isEmpty()?0:r.arguments().first().toInt(); }
    bool getBool(const char* n){ auto r=iface.call(n); return r.arguments().isEmpty()?false:r.arguments().first().toBool(); }
    int extract(const QVariant &var){
        QVariant cur=var;
        if(cur.canConvert<QDBusVariant>()) cur=cur.value<QDBusVariant>().variant();
        if(cur.canConvert<QVariantMap>()){
            auto m=cur.toMap(); if(m.contains("data")) return m["data"].toInt();
        }
        if(cur.canConvert<QDBusArgument>()){
            QDBusArgument arg=cur.value<QDBusArgument>(); QVariantMap map; arg>>map; if(map.contains("data")) return map["data"].toInt();
        }
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
    int m_cpu=68,m_gpu=55,m_cpuFan=2127,m_cpuFanPct=38,m_waterFan=38,m_waterPump=2;
    bool m_connected=true; QDBusInterface iface;
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
    QTimer t; QObject::connect(&t,&QTimer::timeout,[&](){ telemetry.refresh(); }); t.start(1500);
    return app.exec();
}
#include "main.moc"
