.class public final Lcom/blink/app/TrackingBridge;
.super Ljava/lang/Object;
.source "TrackingBridge.java"


# instance fields
.field private final activity:Lcom/blink/app/MainActivity;


# direct methods
.method public static synthetic $r8$lambda$3a7ggwquYR4kAbBE-g2qcpWn4lg(Lcom/blink/app/TrackingBridge;ZZZZD)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Lcom/blink/app/TrackingBridge;->lambda$syncTrackingSettings$1(ZZZZD)V

    return-void
.end method

.method public static synthetic $r8$lambda$5NsHToWXQNi_8fFdY_etho4VWKg(Lcom/blink/app/TrackingBridge;DDF)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lcom/blink/app/TrackingBridge;->lambda$setGymLocation$2(DDF)V

    return-void
.end method

.method public static synthetic $r8$lambda$GLqYRQREHeKYacJsgDmE6PMAHbo(Lcom/blink/app/TrackingBridge;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/TrackingBridge;->lambda$setGymDetectionEnabled$4(Z)V

    return-void
.end method

.method public static synthetic $r8$lambda$nmZFV2RVeWt8rKGQK72FrHUVwuY(Lcom/blink/app/TrackingBridge;DDF)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lcom/blink/app/TrackingBridge;->lambda$setSyncedGymLocation$3(DDF)V

    return-void
.end method

.method public static synthetic $r8$lambda$sacENk77aV4uAvC6MScwS1VrgxQ(Lcom/blink/app/TrackingBridge;ZZZZD)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Lcom/blink/app/TrackingBridge;->lambda$setTrackingSettings$0(ZZZZD)V

    return-void
.end method

.method constructor <init>(Lcom/blink/app/MainActivity;)V
    .locals 0
    .param p1, "activity"    # Lcom/blink/app/MainActivity;

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    iput-object p1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    .line 12
    return-void
.end method

.method private synthetic lambda$setGymDetectionEnabled$4(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .line 100
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0, p1}, Lcom/blink/app/MainActivity;->setGymDetectionEnabled(Z)V

    return-void
.end method

.method private synthetic lambda$setGymLocation$2(DDF)V
    .locals 6
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F

    .line 90
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    move-wide v1, p1

    move-wide v3, p3

    move v5, p5

    .end local p1    # "latitude":D
    .end local p3    # "longitude":D
    .end local p5    # "radiusMeters":F
    .local v1, "latitude":D
    .local v3, "longitude":D
    .local v5, "radiusMeters":F
    invoke-virtual/range {v0 .. v5}, Lcom/blink/app/MainActivity;->setGymLocation(DDF)V

    return-void
.end method

.method private synthetic lambda$setSyncedGymLocation$3(DDF)V
    .locals 6
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F

    .line 95
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    move-wide v1, p1

    move-wide v3, p3

    move v5, p5

    .end local p1    # "latitude":D
    .end local p3    # "longitude":D
    .end local p5    # "radiusMeters":F
    .local v1, "latitude":D
    .local v3, "longitude":D
    .local v5, "radiusMeters":F
    invoke-virtual/range {v0 .. v5}, Lcom/blink/app/MainActivity;->applySyncedGymLocation(DDF)V

    return-void
.end method

.method private synthetic lambda$setTrackingSettings$0(ZZZZD)V
    .locals 7
    .param p1, "locationEnabled"    # Z
    .param p2, "activityEnabled"    # Z
    .param p3, "gymEnabled"    # Z
    .param p4, "sleepEnabled"    # Z
    .param p5, "sleepTargetHours"    # D

    .line 72
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-wide v5, p5

    .end local p1    # "locationEnabled":Z
    .end local p2    # "activityEnabled":Z
    .end local p3    # "gymEnabled":Z
    .end local p4    # "sleepEnabled":Z
    .end local p5    # "sleepTargetHours":D
    .local v1, "locationEnabled":Z
    .local v2, "activityEnabled":Z
    .local v3, "gymEnabled":Z
    .local v4, "sleepEnabled":Z
    .local v5, "sleepTargetHours":D
    invoke-virtual/range {v0 .. v6}, Lcom/blink/app/MainActivity;->applyTrackingSettings(ZZZZD)V

    return-void
.end method

.method private synthetic lambda$syncTrackingSettings$1(ZZZZD)V
    .locals 7
    .param p1, "locationEnabled"    # Z
    .param p2, "activityEnabled"    # Z
    .param p3, "gymEnabled"    # Z
    .param p4, "sleepEnabled"    # Z
    .param p5, "sleepTargetHours"    # D

    .line 84
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-wide v5, p5

    .end local p1    # "locationEnabled":Z
    .end local p2    # "activityEnabled":Z
    .end local p3    # "gymEnabled":Z
    .end local p4    # "sleepEnabled":Z
    .end local p5    # "sleepTargetHours":D
    .local v1, "locationEnabled":Z
    .local v2, "activityEnabled":Z
    .local v3, "gymEnabled":Z
    .local v4, "sleepEnabled":Z
    .local v5, "sleepTargetHours":D
    invoke-virtual/range {v0 .. v6}, Lcom/blink/app/MainActivity;->applySyncedTrackingSettings(ZZZZD)V

    return-void
.end method


# virtual methods
.method public getAppUsageToday()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 21
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->appUsageTodayJson()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getCurrentLocation()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 26
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/LocationHistoryStore;->latest(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->currentLocationJson()Ljava/lang/String;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method public getLocationHistory(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "date"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v0, p1}, Lcom/blink/app/LocationHistoryStore;->readDay(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLocationHistoryYear(I)Ljava/lang/String;
    .locals 1
    .param p1, "year"    # I
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v0, p1}, Lcom/blink/app/LocationHistoryStore;->readYear(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getTrackingState()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 16
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->trackingStateJson()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public hasNotificationPermission()Z
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 61
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->hasNotificationPermission()Z

    move-result v0

    return v0
.end method

.method public openAppLocationSettings()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 120
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda1;

    invoke-direct {v2, v1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda1;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v2}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 121
    return-void
.end method

.method public openUsageAccessSettings()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 125
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda6;

    invoke-direct {v2, v1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda6;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v2}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 126
    return-void
.end method

.method public refreshSleepEstimate()Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 130
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->refreshSleepEstimate()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public requestClassReminderPermission()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 46
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda7;

    invoke-direct {v2, v1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda7;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v2}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 47
    return-void
.end method

.method public requestGoogleSignIn(Ljava/lang/String;)V
    .locals 1
    .param p1, "requestId"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 31
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0, p1}, Lcom/blink/app/MainActivity;->requestGoogleSignIn(Ljava/lang/String;)V

    .line 32
    return-void
.end method

.method public requestGymDetectionPermissions()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 105
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda0;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v2}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 106
    return-void
.end method

.method public saveScheduleBackup(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "contents"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 51
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0, p1, p2}, Lcom/blink/app/MainActivity;->saveScheduleBackup(Ljava/lang/String;Ljava/lang/String;)V

    .line 52
    return-void
.end method

.method public selectScheduleFile(Ljava/lang/String;)V
    .locals 1
    .param p1, "kind"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 56
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0, p1}, Lcom/blink/app/MainActivity;->selectScheduleFile(Ljava/lang/String;)V

    .line 57
    return-void
.end method

.method public setGymDetectionEnabled(Z)V
    .locals 2
    .param p1, "enabled"    # Z
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 100
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    new-instance v1, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0, p1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda4;-><init>(Lcom/blink/app/TrackingBridge;Z)V

    invoke-virtual {v0, v1}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 101
    return-void
.end method

.method public setGymLocation(DDF)V
    .locals 8
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 90
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    new-instance v1, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda10;

    move-object v2, p0

    move-wide v3, p1

    move-wide v5, p3

    move v7, p5

    .end local p1    # "latitude":D
    .end local p3    # "longitude":D
    .end local p5    # "radiusMeters":F
    .local v3, "latitude":D
    .local v5, "longitude":D
    .local v7, "radiusMeters":F
    invoke-direct/range {v1 .. v7}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda10;-><init>(Lcom/blink/app/TrackingBridge;DDF)V

    invoke-virtual {v0, v1}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 91
    return-void
.end method

.method public setLocationScheduleEnabled(Z)V
    .locals 1
    .param p1, "enabled"    # Z
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v0, p1}, Lcom/blink/app/LocationSchedule;->setEnabled(Landroid/content/Context;Z)V

    return-void
.end method

.method public setSyncedGymLocation(DDF)V
    .locals 8
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 95
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    new-instance v1, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda8;

    move-object v2, p0

    move-wide v3, p1

    move-wide v5, p3

    move v7, p5

    .end local p1    # "latitude":D
    .end local p3    # "longitude":D
    .end local p5    # "radiusMeters":F
    .local v3, "latitude":D
    .local v5, "longitude":D
    .local v7, "radiusMeters":F
    invoke-direct/range {v1 .. v7}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda8;-><init>(Lcom/blink/app/TrackingBridge;DDF)V

    invoke-virtual {v0, v1}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 96
    return-void
.end method

.method public setTrackingSettings(ZZZZD)V
    .locals 9
    .param p1, "locationEnabled"    # Z
    .param p2, "activityEnabled"    # Z
    .param p3, "gymEnabled"    # Z
    .param p4, "sleepEnabled"    # Z
    .param p5, "sleepTargetHours"    # D
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 72
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    new-instance v1, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda3;

    move-object v2, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move-wide v7, p5

    .end local p1    # "locationEnabled":Z
    .end local p2    # "activityEnabled":Z
    .end local p3    # "gymEnabled":Z
    .end local p4    # "sleepEnabled":Z
    .end local p5    # "sleepTargetHours":D
    .local v3, "locationEnabled":Z
    .local v4, "activityEnabled":Z
    .local v5, "gymEnabled":Z
    .local v6, "sleepEnabled":Z
    .local v7, "sleepTargetHours":D
    invoke-direct/range {v1 .. v8}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda3;-><init>(Lcom/blink/app/TrackingBridge;ZZZZD)V

    invoke-virtual {v0, v1}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 74
    return-void
.end method

.method public showNotification(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "expression"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 41
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0, p1, p2}, Lcom/blink/app/MainActivity;->showNotification(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    return-void
.end method

.method public signOutGoogle()V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 36
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->signOutGoogle()V

    .line 37
    return-void
.end method

.method public startCardio()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 110
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda2;

    invoke-direct {v2, v1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda2;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v2}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 111
    return-void
.end method

.method public stopCardio()V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 115
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda5;

    invoke-direct {v2, v1}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda5;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v2}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 116
    return-void
.end method

.method public syncTrackingRecords(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "cardioJson"    # Ljava/lang/String;
    .param p2, "gymJson"    # Ljava/lang/String;
    .param p3, "sleepJson"    # Ljava/lang/String;
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 136
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 137
    .local v0, "cardio":Lorg/json/JSONObject;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 138
    .local v1, "gym":Lorg/json/JSONObject;
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 139
    .local v2, "sleep":Lorg/json/JSONObject;
    new-instance v3, Lcom/blink/app/TrackingStore;

    iget-object v4, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    invoke-direct {v3, v4}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0, v1, v2}, Lcom/blink/app/TrackingStore;->mergeCloudRecords(Lorg/json/JSONObject;Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 142
    .end local v0    # "cardio":Lorg/json/JSONObject;
    .end local v1    # "gym":Lorg/json/JSONObject;
    .end local v2    # "sleep":Lorg/json/JSONObject;
    goto :goto_0

    .line 140
    :catch_0
    move-exception v0

    .line 141
    .local v0, "error":Ljava/lang/Exception;
    const-string v1, "BLINK"

    const-string v2, "Could not merge synced tracking records."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 143
    .end local v0    # "error":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public syncTrackingSettings(ZZZZD)V
    .locals 9
    .param p1, "locationEnabled"    # Z
    .param p2, "activityEnabled"    # Z
    .param p3, "gymEnabled"    # Z
    .param p4, "sleepEnabled"    # Z
    .param p5, "sleepTargetHours"    # D
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 84
    iget-object v0, p0, Lcom/blink/app/TrackingBridge;->activity:Lcom/blink/app/MainActivity;

    new-instance v1, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda9;

    move-object v2, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move-wide v7, p5

    .end local p1    # "locationEnabled":Z
    .end local p2    # "activityEnabled":Z
    .end local p3    # "gymEnabled":Z
    .end local p4    # "sleepEnabled":Z
    .end local p5    # "sleepTargetHours":D
    .local v3, "locationEnabled":Z
    .local v4, "activityEnabled":Z
    .local v5, "gymEnabled":Z
    .local v6, "sleepEnabled":Z
    .local v7, "sleepTargetHours":D
    invoke-direct/range {v1 .. v8}, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda9;-><init>(Lcom/blink/app/TrackingBridge;ZZZZD)V

    invoke-virtual {v0, v1}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 86
    return-void
.end method
