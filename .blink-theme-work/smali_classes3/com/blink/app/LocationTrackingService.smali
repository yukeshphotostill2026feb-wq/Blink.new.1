.class public final Lcom/blink/app/LocationTrackingService;
.super Landroid/app/Service;
.source "LocationTrackingService.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# static fields
.field static final ACTION_START:Ljava/lang/String; = "com.blink.app.START_TRACKING"

.field static final ACTION_STOP:Ljava/lang/String; = "com.blink.app.STOP_TRACKING"

.field static final CHANNEL_ID:Ljava/lang/String; = "blink_tracking"

.field private static final NOTIFICATION_ID:I = 0x19c


# instance fields
.field private locationCallback:Lcom/google/android/gms/location/LocationCallback;

.field private locationClient:Lcom/google/android/gms/location/FusedLocationProviderClient;

.field private previousLocation:Landroid/location/Location;

.field private sensorManager:Landroid/hardware/SensorManager;

.field private stepDetector:Landroid/hardware/Sensor;

.field private store:Lcom/blink/app/TrackingStore;


# direct methods
.method public static synthetic $r8$lambda$ivCYus5QCfgATwomqBaYIqU1tBs(Lcom/blink/app/LocationTrackingService;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/LocationTrackingService;->lambda$beginUpdates$0(Ljava/lang/Exception;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$mprocessLocation(Lcom/blink/app/LocationTrackingService;Landroid/location/Location;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/LocationTrackingService;->processLocation(Landroid/location/Location;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$mupdateNotification(Lcom/blink/app/LocationTrackingService;)V
    .locals 0

    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->updateNotification()V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method private beginUpdates()V
    .locals 4

    .line 81
    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    .line 83
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    const-string v1, "Precise location permission is required for cardio tracking."

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 84
    invoke-virtual {p0}, Lcom/blink/app/LocationTrackingService;->stopSelf()V

    .line 85
    return-void

    .line 88
    :cond_0
    :try_start_0
    new-instance v0, Lcom/google/android/gms/location/LocationRequest$Builder;

    const/16 v1, 0x64

    const-wide/16 v2, 0x1388

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/location/LocationRequest$Builder;-><init>(IJ)V

    .line 89
    const-wide/16 v1, 0x7d0

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/location/LocationRequest$Builder;->setMinUpdateIntervalMillis(J)Lcom/google/android/gms/location/LocationRequest$Builder;

    move-result-object v0

    .line 90
    const-wide/16 v1, 0x2710

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/location/LocationRequest$Builder;->setMaxUpdateDelayMillis(J)Lcom/google/android/gms/location/LocationRequest$Builder;

    move-result-object v0

    .line 91
    invoke-virtual {v0}, Lcom/google/android/gms/location/LocationRequest$Builder;->build()Lcom/google/android/gms/location/LocationRequest;

    move-result-object v0

    .line 92
    .local v0, "request":Lcom/google/android/gms/location/LocationRequest;
    iget-object v1, p0, Lcom/blink/app/LocationTrackingService;->locationClient:Lcom/google/android/gms/location/FusedLocationProviderClient;

    iget-object v2, p0, Lcom/blink/app/LocationTrackingService;->locationCallback:Lcom/google/android/gms/location/LocationCallback;

    invoke-virtual {p0}, Lcom/blink/app/LocationTrackingService;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-interface {v1, v0, v2, v3}, Lcom/google/android/gms/location/FusedLocationProviderClient;->requestLocationUpdates(Lcom/google/android/gms/location/LocationRequest;Lcom/google/android/gms/location/LocationCallback;Landroid/os/Looper;)Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    new-instance v2, Lcom/blink/app/LocationTrackingService$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0}, Lcom/blink/app/LocationTrackingService$$ExternalSyntheticLambda0;-><init>(Lcom/blink/app/LocationTrackingService;)V

    .line 93
    invoke-virtual {v1, v2}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 100
    nop

    .end local v0    # "request":Lcom/google/android/gms/location/LocationRequest;
    goto :goto_0

    .line 97
    :catch_0
    move-exception v0

    .line 98
    .local v0, "error":Ljava/lang/SecurityException;
    iget-object v1, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    const-string v2, "Location permission was removed while tracking."

    invoke-virtual {v1, v2}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 99
    invoke-virtual {p0}, Lcom/blink/app/LocationTrackingService;->stopSelf()V

    .line 101
    .end local v0    # "error":Ljava/lang/SecurityException;
    :goto_0
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isActivityTrackingEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->stepDetector:Landroid/hardware/Sensor;

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->hasActivityPermission()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 102
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->sensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/blink/app/LocationTrackingService;->stepDetector:Landroid/hardware/Sensor;

    const/4 v2, 0x3

    invoke-virtual {v0, p0, v1, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    .line 103
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 105
    :cond_1
    return-void
.end method

.method private buildNotification()Landroid/app/Notification;
    .locals 4

    .line 158
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/MainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 159
    .local v0, "open":Landroid/content/Intent;
    const/4 v1, 0x0

    const/high16 v2, 0xc000000

    invoke-static {p0, v1, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 161
    .local v1, "contentIntent":Landroid/app/PendingIntent;
    new-instance v2, Landroidx/core/app/NotificationCompat$Builder;

    const-string v3, "blink_tracking"

    invoke-direct {v2, p0, v3}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 162
    const v3, 0x1080047

    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    const v3, -0xfd2be

    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setColor(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 163
    const-string v3, "BLINK location tracking"

    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 164
    iget-object v3, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    invoke-virtual {v3}, Lcom/blink/app/TrackingStore;->hasActiveCardio()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 165
    const-string v3, "Cardio session in progress \u00b7 GPS distance only"

    goto :goto_0

    :cond_0
    const-string v3, "Tracking active"

    .line 164
    :goto_0
    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 166
    invoke-virtual {v2, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 167
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setOngoing(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 168
    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setOnlyAlertOnce(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 169
    const-string v3, "service"

    invoke-virtual {v2, v3}, Landroidx/core/app/NotificationCompat$Builder;->setCategory(Ljava/lang/String;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 170
    invoke-virtual {v2}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    .line 161
    return-object v2
.end method

.method private hasActivityPermission()Z
    .locals 2

    .line 108
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_1

    .line 109
    const-string v0, "android.permission.ACTIVITY_RECOGNITION"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 108
    :goto_1
    return v0
.end method

.method private synthetic lambda$beginUpdates$0(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "error"    # Ljava/lang/Exception;

    .line 94
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Android location updates failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 95
    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->updateNotification()V

    .line 96
    return-void
.end method

.method private processLocation(Landroid/location/Location;)V
    .locals 25
    .param p1, "location"    # Landroid/location/Location;

    .line 114
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    if-eqz v1, :cond_5

    invoke-virtual {v1}, Landroid/location/Location;->hasAccuracy()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-virtual {v1}, Landroid/location/Location;->getAccuracy()F

    move-result v2

    const/high16 v3, 0x420c0000    # 35.0f

    cmpl-float v2, v2, v3

    if-lez v2, :cond_0

    goto/16 :goto_2

    .line 115
    :cond_0
    invoke-virtual {v1}, Landroid/location/Location;->getTime()J

    move-result-wide v4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    const-wide/16 v8, 0x7530

    sub-long/2addr v6, v8

    cmp-long v2, v4, v6

    if-gez v2, :cond_1

    return-void

    .line 116
    :cond_1

    invoke-virtual {v1}, Landroid/location/Location;->hasSpeed()Z

    move-result v2

    const/4 v4, 0x0

    if-eqz v2, :cond_2

    invoke-virtual {v1}, Landroid/location/Location;->getSpeed()F

    move-result v2

    cmpl-float v2, v2, v4

    if-ltz v2, :cond_2

    .line 117
    invoke-virtual {v1}, Landroid/location/Location;->getSpeed()F

    move-result v4

    goto :goto_0

    :cond_2
    nop

    .line 119
    .local v4, "speed":F
    :goto_0
    iget-object v2, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    if-eqz v2, :cond_4

    .line 120
    invoke-virtual {v1}, Landroid/location/Location;->getTime()J

    move-result-wide v5

    iget-object v2, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    invoke-virtual {v2}, Landroid/location/Location;->getTime()J

    move-result-wide v10

    sub-long/2addr v5, v10

    .line 121
    .local v5, "deltaMillis":J
    const-wide/16 v10, 0x0

    cmp-long v2, v5, v10

    if-lez v2, :cond_4

    cmp-long v2, v5, v8

    if-gtz v2, :cond_4

    .line 122
    const/4 v2, 0x1

    new-array v15, v2, [F

    .line 123
    .local v15, "result":[F
    iget-object v2, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    .line 124
    invoke-virtual {v2}, Landroid/location/Location;->getLatitude()D

    move-result-wide v7

    iget-object v2, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    invoke-virtual {v2}, Landroid/location/Location;->getLongitude()D

    move-result-wide v9

    .line 125
    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v11

    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v13

    .line 123
    invoke-static/range {v7 .. v15}, Landroid/location/Location;->distanceBetween(DDDD[F)V

    .line 126
    const/4 v2, 0x0

    aget v2, v15, v2

    float-to-double v7, v2

    .line 127
    .local v7, "distance":D
    long-to-double v9, v5

    const-wide v11, 0x408f400000000000L    # 1000.0

    div-double/2addr v9, v11

    div-double v9, v7, v9

    .line 128
    .local v9, "derivedSpeed":D
    const-wide/high16 v11, 0x3ff8000000000000L    # 1.5

    cmpl-double v2, v7, v11

    if-ltz v2, :cond_4

    const-wide v11, 0x4062c00000000000L    # 150.0

    cmpg-double v2, v7, v11

    if-gtz v2, :cond_4

    const-wide/high16 v11, 0x4020000000000000L    # 8.0

    cmpg-double v2, v9, v11

    if-gtz v2, :cond_4

    .line 129
    invoke-virtual {v1}, Landroid/location/Location;->getAccuracy()F

    move-result v2

    iget-object v11, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    invoke-virtual {v11}, Landroid/location/Location;->getAccuracy()F

    move-result v11

    invoke-static {v2, v11}, Ljava/lang/Math;->max(FF)F

    move-result v2

    cmpg-float v2, v2, v3

    if-gtz v2, :cond_4

    invoke-virtual {v1}, Landroid/location/Location;->hasSpeed()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-virtual {v1}, Landroid/location/Location;->getSpeed()F

    move-result v2

    const v3, 0x3f0ccccd

    cmpg-float v2, v2, v3

    if-ltz v2, :cond_4

    :cond_6
    invoke-virtual {v1}, Landroid/location/Location;->getAccuracy()F

    move-result v2

    iget-object v3, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    invoke-virtual {v3}, Landroid/location/Location;->getAccuracy()F

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v2

    const v3, 0x3f000000

    mul-float/2addr v2, v3

    float-to-double v2, v2

    const-wide/high16 v11, 0x4014000000000000L

    invoke-static {v2, v3, v11, v12}, Ljava/lang/Math;->max(DD)D

    move-result-wide v11

    cmpg-double v2, v7, v11

    if-lez v2, :cond_4

    .line 130
    iget-object v2, v0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    invoke-virtual {v2, v7, v8}, Lcom/blink/app/TrackingStore;->addDistance(D)V

    .line 131
    invoke-virtual {v1}, Landroid/location/Location;->hasSpeed()Z

    move-result v2

    if-nez v2, :cond_3

    double-to-float v4, v9

    move/from16 v22, v4

    goto :goto_1

    .line 132
    :cond_3
    const v2, 0x3f0ccccd    # 0.55f

    cmpg-float v2, v4, v2

    if-gez v2, :cond_4

    const-wide v2, 0x3fe199999999999aL    # 0.55

    cmpl-double v2, v9, v2

    if-ltz v2, :cond_4

    double-to-float v4, v9

    move/from16 v22, v4

    goto :goto_1

    .line 136
    .end local v5    # "deltaMillis":J
    .end local v7    # "distance":D
    .end local v9    # "derivedSpeed":D
    .end local v15    # "result":[F
    :cond_4
    move/from16 v22, v4

    .end local v4    # "speed":F
    .local v22, "speed":F
    :goto_1
    iget-object v2, v0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v17

    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v19

    .line 137
    invoke-virtual {v1}, Landroid/location/Location;->getAccuracy()F

    move-result v21

    invoke-virtual {v1}, Landroid/location/Location;->getTime()J

    move-result-wide v23

    .line 136
    move-object/from16 v16, v2

    invoke-virtual/range {v16 .. v24}, Lcom/blink/app/TrackingStore;->recordLocation(DDFFJ)V

    .line 138
    iput-object v1, v0, Lcom/blink/app/LocationTrackingService;->previousLocation:Landroid/location/Location;

    .line 139
    return-void

    .line 114
    .end local v22    # "speed":F
    :cond_5
    :goto_2
    return-void
.end method

.method private updateNotification()V
    .locals 3

    .line 174
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/blink/app/LocationTrackingService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 175
    .local v0, "manager":Landroid/app/NotificationManager;
    if-eqz v0, :cond_0

    const/16 v1, 0x19c

    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->buildNotification()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 176
    :cond_0
    invoke-static {}, Lcom/blink/app/MainActivityReference;->get()Lcom/blink/app/MainActivity;

    move-result-object v1

    .line 177
    .local v1, "activity":Lcom/blink/app/MainActivity;
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 178
    :cond_1
    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 2
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .line 151
    if-nez p2, :cond_0

    .line 152
    invoke-virtual {p1}, Landroid/hardware/Sensor;->getType()I

    move-result v0

    const/16 v1, 0x12

    if-ne v0, v1, :cond_0

    .line 153
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    const-string v1, "The device step sensor is temporarily unreliable."

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 155
    :cond_0
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .line 195
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 2

    .line 44
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 45
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    .line 46
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceRunning(Z)V

    .line 47
    invoke-static {p0}, Lcom/google/android/gms/location/LocationServices;->getFusedLocationProviderClient(Landroid/content/Context;)Lcom/google/android/gms/location/FusedLocationProviderClient;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/LocationTrackingService;->locationClient:Lcom/google/android/gms/location/FusedLocationProviderClient;

    .line 48
    const-string v0, "sensor"

    invoke-virtual {p0, v0}, Lcom/blink/app/LocationTrackingService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/blink/app/LocationTrackingService;->sensorManager:Landroid/hardware/SensorManager;

    .line 49
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->sensorManager:Landroid/hardware/SensorManager;

    const/16 v1, 0x12

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/LocationTrackingService;->stepDetector:Landroid/hardware/Sensor;

    .line 50
    new-instance v0, Lcom/blink/app/LocationTrackingService$1;

    invoke-direct {v0, p0}, Lcom/blink/app/LocationTrackingService$1;-><init>(Lcom/blink/app/LocationTrackingService;)V

    iput-object v0, p0, Lcom/blink/app/LocationTrackingService;->locationCallback:Lcom/google/android/gms/location/LocationCallback;

    .line 57
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 182
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->locationClient:Lcom/google/android/gms/location/FusedLocationProviderClient;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->locationCallback:Lcom/google/android/gms/location/LocationCallback;

    if-eqz v0, :cond_0

    .line 183
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->locationClient:Lcom/google/android/gms/location/FusedLocationProviderClient;

    iget-object v1, p0, Lcom/blink/app/LocationTrackingService;->locationCallback:Lcom/google/android/gms/location/LocationCallback;

    invoke-interface {v0, v1}, Lcom/google/android/gms/location/FusedLocationProviderClient;->removeLocationUpdates(Lcom/google/android/gms/location/LocationCallback;)Lcom/google/android/gms/tasks/Task;

    .line 185
    :cond_0
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->sensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->sensorManager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 186
    :cond_1
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceRunning(Z)V

    .line 187
    invoke-static {}, Lcom/blink/app/MainActivityReference;->get()Lcom/blink/app/MainActivity;

    move-result-object v0

    .line 188
    .local v0, "activity":Lcom/blink/app/MainActivity;
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 189
    :cond_2
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 190
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 2
    .param p1, "event"    # Landroid/hardware/SensorEvent;

    .line 143
    iget-object v0, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getType()I

    move-result v0

    const/16 v1, 0x12

    if-ne v0, v1, :cond_0

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    array-length v0, v0

    if-lez v0, :cond_0

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    const/4 v1, 0x0

    cmpl-float v0, v0, v1

    if-lez v0, :cond_0

    .line 145
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->recordStep()V

    .line 147
    :cond_0
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 5
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .line 61
    if-nez p1, :cond_0

    const-string v0, "com.blink.app.START_TRACKING"

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 62
    .local v0, "action":Ljava/lang/String;
    :goto_0
    const-string v1, "com.blink.app.STOP_TRACKING"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 63
    invoke-virtual {p0}, Lcom/blink/app/LocationTrackingService;->stopSelf()V

    .line 64
    const/4 v1, 0x2

    return v1

    .line 66
    :cond_1
    const/16 v1, 0x8

    .line 67
    .local v1, "serviceType":I
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x22

    if-lt v2, v3, :cond_2

    iget-object v2, p0, Lcom/blink/app/LocationTrackingService;->store:Lcom/blink/app/TrackingStore;

    .line 68
    invoke-virtual {v2}, Lcom/blink/app/TrackingStore;->isActivityTrackingEnabled()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->hasActivityPermission()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 69
    or-int/lit16 v1, v1, 0x100

    .line 71
    :cond_2
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    const/16 v4, 0x19c

    if-lt v2, v3, :cond_3

    .line 72
    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->buildNotification()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {p0, v4, v2, v1}, Lcom/blink/app/LocationTrackingService;->startForeground(ILandroid/app/Notification;I)V

    goto :goto_1

    .line 74
    :cond_3
    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->buildNotification()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {p0, v4, v2}, Lcom/blink/app/LocationTrackingService;->startForeground(ILandroid/app/Notification;)V

    .line 76
    :goto_1
    invoke-direct {p0}, Lcom/blink/app/LocationTrackingService;->beginUpdates()V

    .line 77
    const/4 v2, 0x1

    return v2
.end method
