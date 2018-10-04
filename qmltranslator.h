#ifndef QMLTRANSLATOR_H
#define QMLTRANSLATOR_H

#include <QObject>
#include <QTranslator>

class QmlTranslator : public QObject
{
 Q_OBJECT
 Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)
Q_PROPERTY(double fontVal READ fontVal WRITE setfontVal)

 public:
  QmlTranslator() {
   translator1 = new QTranslator(this);
  }
  void setfontVal(const double &a) { if (a != m_fontVal) { m_fontVal = a;} }
  double fontVal() const { return m_fontVal; }


  QString getEmptyString() {
   return "";
  }

 Q_INVOKABLE void selectLanguage(QString language);

 signals:
  void languageChanged();

 private:
  QTranslator *translator1;
  double m_fontVal = 0;
};

#endif // QMLTRANSLATOR_H
