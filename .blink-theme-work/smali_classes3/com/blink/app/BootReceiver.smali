.class public final Lcom/blink/app/BootReceiver;
.super Landroid/content/BroadcastReceiver;
.source "BootReceiver.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 12
    if-eqz p2, :cond_2

    const-string v0, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 13
    :cond_0
    invoke-static {p1}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p1}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 14
    .local v0, "store":Lcom/blink/app/TrackingStore;
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 15
    invoke-static {p1}, Lcom/google/android/gms/location/LocationServices;->getGeofencingClient(Landroid/content/Context;)Lcom/google/android/gms/location/GeofencingClient;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/blink/app/TrackingStore;->registerGymGeofence(Landroid/content/Context;Lcom/google/android/gms/location/GeofencingClient;)V

    .line 17
    :cond_1
    return-void

    .line 12
    .end local v0    # "store":Lcom/blink/app/TrackingStore;
    :cond_2
    :goto_0
    return-void
.end method
