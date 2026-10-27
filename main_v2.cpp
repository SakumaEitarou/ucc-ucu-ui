
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDebug>

// Включи реальные заголовки из upstream/libucc-dbus
// После копирования они будут в libucc-dbus/
#include "libucc-dbus/dbus_client.h" // адаптируй путь

class RealTelemetry : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY updated)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY updated)
    Q_PROPERTY(int liquidTemp READ liquidTemp NOTIFY updated)
public:
    int cpuTemp() { return m_cpu; }
    int gpuTemp() { return m_gpu; }
    int liquidTemp() { return m_liquid; }
    Q_INVOKABLE void refresh() {
        // Читай из uccd через D-Bus, пример:
        // QDBusInterface iface("org.ucc.daemon","/org/ucc/daemon","org.ucc.daemon", QDBusConnection::systemBus());
        // m_cpu = iface.call("GetCpuTemp").arguments().first().toInt();
        // m_gpu = iface.call("GetGpuTemp").arguments().first().toInt();
        Q_EMIT updated();
    }
signals:
    void updated();
private:
    int m_cpu=0,m_gpu=0,m_liquid=0;
};

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    RealTelemetry telemetry;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Telemetry", &telemetry);
    // таймер обновления каждые 2 сек как в UCU
    QTimer timer; QObject::connect(&timer,&QTimer::timeout,[&](){ telemetry.refresh(); });
    timer.start(2000);
    engine.load(QUrl(QStringLiteral("qrc:/UCC/UCU/qml/Main.qml")));
    return app.exec();
}
#include "main_v2.moc"
