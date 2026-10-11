.class public final Lcom/blink/app/GymGeofenceReceiver;
.super Landroid/content/BroadcastReceiver;
.source "GymGeofenceReceiver.java"


# static fields
.field private static final GEOFENCE_REQUEST:I = 0x125d

.field private static final WINDOW_REQUEST:I = 0x125e


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method static cancelWindow(Landroid/content/Context;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .line 55
    const-class v0, Landroid/app/AlarmManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 56
    .local v0, "alarm":Landroid/app/AlarmManager;
    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/blink/app/GymGeofenceReceiver;->windowIntent(Landroid/content/Context;)Landroid/app/PendingIntent;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 57
    :cond_0
    return-void
.end method

.method static pendingIntent(Landroid/content/Context;)Landroid/app/PendingIntent;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 24
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/GymGeofenceReceiver;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 25
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x8000000

    .line 26
    .local v1, "flags":I
    const/high16 v2, 0x4000000

    or-int/2addr v1, v2

    .line 27
    const/16 v2, 0x125d

    invoke-static {p0, v2, v0, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    return-object v2
.end method

.method static scheduleNextWindow(Landroid/content/Context;)V
    .locals 8
    .param p0, "context"    # Landroid/content/Context;

    .line 38
    invoke-static {}, Ljava/time/LocalDateTime;->now()Ljava/time/LocalDateTime;

    move-result-object v0

    .line 40
    .local v0, "now":Ljava/time/LocalDateTime;
    invoke-virtual {v0}, Ljava/time/LocalDateTime;->toLocalTime()Ljava/time/LocalTime;

    move-result-object v1

    const/16 v2, 0x10

    const/16 v3, 0x1e

    invoke-static {v2, v3}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 41
    invoke-virtual {v0}, Ljava/time/LocalDateTime;->toLocalDate()Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1, v2, v3}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v1

    .local v1, "next":Ljava/time/LocalDateTime;
    goto :goto_0

    .line 42
    .end local v1    # "next":Ljava/time/LocalDateTime;
    :cond_0
    invoke-virtual {v0}, Ljava/time/LocalDateTime;->toLocalTime()Ljava/time/LocalTime;

    move-result-object v1

    const/16 v4, 0x13

    const/16 v5, 0x1e

    invoke-static {v4, v5}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 43
    invoke-virtual {v0}, Ljava/time/LocalDateTime;->toLocalDate()Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1, v4, v5}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v1

    .restart local v1    # "next":Ljava/time/LocalDateTime;
    goto :goto_0

    .line 45
    .end local v1    # "next":Ljava/time/LocalDateTime;
    :cond_1
    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v1

    const-wide/16 v4, 0x1

    invoke-virtual {v1, v4, v5}, Ljava/time/LocalDate;->plusDays(J)Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1, v2, v3}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v1

    .line 47
    .restart local v1    # "next":Ljava/time/LocalDateTime;
    :goto_0
    const-class v2, Landroid/app/AlarmManager;

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/AlarmManager;

    .line 48
    .local v2, "alarm":Landroid/app/AlarmManager;
    if-nez v2, :cond_2

    return-void

    .line 49
    :cond_2
    invoke-static {p0}, Lcom/blink/app/GymGeofenceReceiver;->windowIntent(Landroid/content/Context;)Landroid/app/PendingIntent;

    move-result-object v4

    .line 50
    .local v4, "intent":Landroid/app/PendingIntent;
    invoke-static {}, Ljava/time/ZoneId;->systemDefault()Ljava/time/ZoneId;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v5

    invoke-virtual {v5}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v5

    invoke-virtual {v5}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v5

    .line 51
    .local v5, "triggerAt":J
    const/4 v7, 0x0

    invoke-virtual {v2, v7, v5, v6, v4}, Landroid/app/AlarmManager;->setAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    .line 52
    return-void
.end method

.method private static windowIntent(Landroid/content/Context;)Landroid/app/PendingIntent;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 31
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/GymGeofenceReceiver;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.blink.app.GYM_WINDOW"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 32
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x8000000

    .line 33
    .local v1, "flags":I
    const/high16 v2, 0x4000000

    or-int/2addr v1, v2

    .line 34
    const/16 v2, 0x125e

    invoke-static {p0, v2, v0, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    return-object v2
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 61
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p1}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 62
    .local v0, "store":Lcom/blink/app/TrackingStore;
    if-eqz p2, :cond_1

    const-string v1, "com.blink.app.GYM_WINDOW"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 63
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->checkGymWindow()V

    .line 64
    invoke-static {p1}, Lcom/blink/app/GymGeofenceReceiver;->scheduleNextWindow(Landroid/content/Context;)V

    .line 65
    invoke-static {}, Lcom/blink/app/MainActivityReference;->get()Lcom/blink/app/MainActivity;

    move-result-object v1

    .line 66
    .local v1, "activity":Lcom/blink/app/MainActivity;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 67
    :cond_0
    return-void

    .line 69
    .end local v1    # "activity":Lcom/blink/app/MainActivity;
    :cond_1
    invoke-static {p2}, Lcom/google/android/gms/location/GeofencingEvent;->fromIntent(Landroid/content/Intent;)Lcom/google/android/gms/location/GeofencingEvent;

    move-result-object v1

    .line 70
    .local v1, "event":Lcom/google/android/gms/location/GeofencingEvent;
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Lcom/google/android/gms/location/GeofencingEvent;->hasError()Z

    move-result v2

    if-eqz v2, :cond_2

    goto :goto_1

    .line 74
    :cond_2
    invoke-virtual {v1}, Lcom/google/android/gms/location/GeofencingEvent;->getGeofenceTransition()I

    move-result v2

    .line 75
    .local v2, "transition":I
    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    .line 76
    invoke-virtual {v0, v3}, Lcom/blink/app/TrackingStore;->setGymInside(Z)V

    goto :goto_0

    .line 77
    :cond_3
    const/4 v3, 0x2

    if-ne v2, v3, :cond_4

    .line 78
    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lcom/blink/app/TrackingStore;->setGymInside(Z)V

    .line 80
    :cond_4
    :goto_0
    invoke-static {p1}, Lcom/blink/app/GymGeofenceReceiver;->scheduleNextWindow(Landroid/content/Context;)V

    .line 81
    invoke-static {}, Lcom/blink/app/MainActivityReference;->get()Lcom/blink/app/MainActivity;

    move-result-object v3

    .line 82
    .local v3, "activity":Lcom/blink/app/MainActivity;
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 83
    :cond_5
    return-void

    .line 71
    .end local v2    # "transition":I
    .end local v3    # "activity":Lcom/blink/app/MainActivity;
    :cond_6
    :goto_1
    const-string v2, "Android could not read the gym geofence event."

    invoke-virtual {v0, v2}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 72
    return-void
.end method
