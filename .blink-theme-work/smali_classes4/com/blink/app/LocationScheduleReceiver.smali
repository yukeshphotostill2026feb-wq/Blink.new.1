.class public final Lcom/blink/app/LocationScheduleReceiver;
.super Landroid/content/BroadcastReceiver;
.source "LocationScheduleReceiver.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    .line 11
    if-eqz p2, :cond_1

    const-string v0, "com.blink.app.LOCATION_SCHEDULE"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_0

    goto :goto_0

    .line 15
    :cond_0
    invoke-static {p1}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    .line 16
    return-void

    .line 12
    :cond_1
    :goto_0
    const-string p1, "BLINK"

    const-string p2, "Ignored an unexpected location schedule alarm."

    invoke-static {p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 13
    return-void
.end method
