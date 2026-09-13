package com.tamandro.echeances

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class PapierWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val launch = PendingIntent.getActivity(
            context,
            0,
            Intent(context, MainActivity::class.java),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        appWidgetIds.forEach { id ->
            val views = RemoteViews(context.packageName, R.layout.papier_widget).apply {
                setTextViewText(
                    R.id.widget_title,
                    widgetData.getString("title", "Aucune échéance"),
                )
                setTextViewText(
                    R.id.widget_subtitle,
                    widgetData.getString("subtitle", ""),
                )
                setTextViewText(
                    R.id.widget_days,
                    widgetData.getString("days", "—"),
                )
                setOnClickPendingIntent(R.id.widget_root, launch)
            }
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
