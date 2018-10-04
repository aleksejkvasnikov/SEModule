#include "qmltranslator.h"
#include <QApplication>

void QmlTranslator::selectLanguage(QString language) {
  if(language == QString("en_US")) {
   translator1->load("QtLanguage_en", ".");
   qApp->installTranslator(translator1);
  }

  if(language == QString("ru_RU")) {
   qApp->removeTranslator(translator1);
  }

  emit languageChanged();
 }
