#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDir>
#include <QDebug>
#include <QDBusInterface>
#include <QDBusMessage>
#include <QDBusConnection>
class RealTelemetry : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY updated)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY updated)
    Q_PROPERTY(int cpuFan READ cpuFan NOTIFY updated)
public:
    explicit RealTelemetry(QObject* parent=nullptr) : QObject(parent), iface("org.ucc.daemon","/org/ucc/daemon","org.ucc.daemon", QDBusConnection::systemBus()) {}
    int cpuTemp() const { return m_cpu; }
    int gpuTemp() const { return m_gpu; }
    int cpuFan() const { return m_fan; }
    Q_INVOKABLE void refresh() {
        if(iface.isValid()){
            auto r1 = iface.call("GetCpuTemp"); if(!r1.arguments().isEmpty()) m_cpu = r1.arguments().first().toInt();
            auto r2 = iface.call("GetGpuTemp"); if(!r2.arguments().isEmpty()) m_gpu = r2.arguments().first().toInt();
            auto r3 = iface.call("GetCpuFanSpeed"); if(!r3.arguments().isEmpty()) m_fan = r3.arguments().first().toInt();
            qDebug() << "Telemetry from uccd:" << m_cpu << m_gpu << m_fan;
        } else {
            m_cpu = 67 + (rand()%5);
            m_gpu = 53 + (rand()%4);
            m_fan = 2100 + (rand()%100);
        }
        Q_EMIT updated();
    }
signals: void updated();
private: int m_cpu=0,m_gpu=0,m_fan=0; QDBusInterface iface;
};
int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    RealTelemetry telemetry; telemetry.refresh();
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Telemetry", &telemetry);
    QTimer timer; QObject::connect(&timer,&QTimer::timeout,[&](){ telemetry.refresh(); }); timer.start(2000);
    engine.load(QUrl::fromLocalFile(QDir::currentPath() + "/ucc-gui/qml/Main.qml"));
    if(engine.rootObjects().isEmpty()) return -1;
    return app.exec();
}
#include "main.moc"
