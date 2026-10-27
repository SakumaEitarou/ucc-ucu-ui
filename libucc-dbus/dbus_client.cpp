
#include "dbus_client.h"
#include <QDebug>
UccDbus::UccDbus(QObject* parent): QObject(parent), m_iface("org.ucc.daemon","/org/ucc/daemon","org.ucc.daemon", QDBusConnection::systemBus()) {
    // TODO: connect to real uccd signals
    qDebug() << "UccDbus connected, iface valid:" << m_iface.isValid();
}
void UccDbus::setPumpSpeed(int p){ qDebug()<<"setPumpSpeed"<<p; m_iface.call("SetPumpSpeed", p); }
void UccDbus::setFanCurve(const QVariantList &c){ qDebug()<<"setFanCurve"<<c; }
void UccDbus::setKeyboardColor(const QString &hex){ m_iface.call("SetKeyboardColor", hex); }
void UccDbus::setPreset(const QString &name){ m_iface.call("SetPreset", name); }
void UccDbus::setLightBarColor(const QString &hex){ m_iface.call("SetLightBarColor", hex); }
