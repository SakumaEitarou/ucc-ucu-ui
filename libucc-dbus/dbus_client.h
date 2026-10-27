
#pragma once
#include <QObject>
#include <QDBusInterface>

class UccDbus : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY telemetryChanged)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY telemetryChanged)
public:
    explicit UccDbus(QObject* parent=nullptr);
    int cpuTemp() const { return m_cpu; }
    int gpuTemp() const { return m_gpu; }

    Q_INVOKABLE void setPumpSpeed(int percent);
    Q_INVOKABLE void setFanCurve(const QVariantList &curve);
    Q_INVOKABLE void setKeyboardColor(const QString &hex);
    Q_INVOKABLE void setPreset(const QString &name);
    Q_INVOKABLE void setLightBarColor(const QString &hex);

signals:
    void telemetryChanged();

private:
    int m_cpu = 68;
    int m_gpu = 54;
    QDBusInterface m_iface;
};
