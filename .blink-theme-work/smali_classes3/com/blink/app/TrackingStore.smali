.class final Lcom/blink/app/TrackingStore;
.super Ljava/lang/Object;
.source "TrackingStore.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blink/app/TrackingStore$LocationServicesProvider;
    }
.end annotation


# static fields
.field static final ACTION_GYM_WINDOW:Ljava/lang/String; = "com.blink.app.GYM_WINDOW"

.field private static final ACTIVE_CARDIO:Ljava/lang/String; = "active_cardio"

.field private static final CARDIO_RECORDS:Ljava/lang/String; = "cardio_records"

.field private static final GYM_RECORDS:Ljava/lang/String; = "gym_records"

.field static final PREFS:Ljava/lang/String; = "blink_tracking"

.field private static final STEPS_BY_DAY:Ljava/lang/String; = "steps_by_day"


# instance fields
.field private final context:Landroid/content/Context;

.field private final prefs:Landroid/content/SharedPreferences;


# direct methods
.method public static synthetic $r8$lambda$OtNBxRqCnunoBb1Za__nKixSCzk(Lcom/blink/app/TrackingStore;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/TrackingStore;->lambda$registerGymGeofence$1(Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$bUvbscRwoJsg7E03YguSU2oEG_M(Lcom/blink/app/TrackingStore;Ljava/lang/Void;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/TrackingStore;->lambda$registerGymGeofence$0(Ljava/lang/Void;)V

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    .line 37
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    const-string v1, "blink_tracking"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    .line 38
    return-void
.end method

.method private activeCardio()Lorg/json/JSONObject;
    .locals 3

    .line 443
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "active_cardio"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blink/app/TrackingStore;->parseObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method private static addIfMissing(Lorg/json/JSONArray;Lorg/json/JSONObject;)V
    .locals 7
    .param p0, "rows"    # Lorg/json/JSONArray;
    .param p1, "row"    # Lorg/json/JSONObject;

    .line 374
    const-string v0, "id"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 375
    .local v1, "id":Ljava/lang/String;
    const-string v2, "date"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 376
    .local v3, "date":Ljava/lang/String;
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v5

    if-ge v4, v5, :cond_3

    .line 377
    invoke-virtual {p0, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    .line 378
    .local v5, "existing":Lorg/json/JSONObject;
    if-eqz v5, :cond_2

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_0

    invoke-virtual {v5, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 379
    :cond_0
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-virtual {v5, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    :cond_1
    return-void

    .line 376
    .end local v5    # "existing":Lorg/json/JSONObject;
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 381
    .end local v4    # "i":I
    :cond_3
    invoke-virtual {p0, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 382
    return-void
.end method

.method private appendRecord(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "row"    # Lorg/json/JSONObject;

    .line 460
    invoke-direct {p0, p1}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 461
    .local v0, "array":Lorg/json/JSONArray;
    invoke-static {v0, p2}, Lcom/blink/app/TrackingStore;->addIfMissing(Lorg/json/JSONArray;Lorg/json/JSONObject;)V

    .line 462
    iget-object v1, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, p1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 463
    return-void
.end method

.method private closeGymSession(Lorg/json/JSONObject;J)V
    .locals 5
    .param p1, "active"    # Lorg/json/JSONObject;
    .param p2, "endTime"    # J

    .line 293
    :try_start_0
    const-string v0, "endTime"

    invoke-virtual {p1, v0, p2, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 294
    const-string v0, "durationSeconds"

    const-string v1, "startTime"

    invoke-virtual {p1, v1, p2, p3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    sub-long v1, p2, v1

    long-to-double v1, v1

    const-wide v3, 0x408f400000000000L    # 1000.0

    div-double/2addr v1, v3

    const-wide/16 v3, 0x0

    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    invoke-virtual {p1, v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 295
    const-string v0, "status"

    const-string v1, "Gym presence recorded"

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 296
    const-string v0, "gym_records"

    invoke-direct {p0, v0, p1}, Lcom/blink/app/TrackingStore;->appendRecord(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 297
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "active_gym"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 300
    goto :goto_0

    .line 298
    :catch_0
    move-exception v0

    .line 299
    .local v0, "error":Lorg/json/JSONException;
    const-string v1, "Could not finish the gym presence session."

    invoke-virtual {p0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 301
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_0
    return-void
.end method

.method private isGymWindowOpen()Z
    .locals 3

    .line 287
    invoke-static {}, Ljava/time/LocalTime;->now()Ljava/time/LocalTime;

    move-result-object v0

    .line 288
    .local v0, "now":Ljava/time/LocalTime;
    const/16 v1, 0x10

    const/16 v2, 0x1e

    invoke-static {v1, v2}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v2

    if-nez v2, :cond_0

    const/16 v1, 0x13

    const/16 v2, 0x1e

    invoke-static {v1, v2}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v2

    return v2

    :cond_0
    const/4 v2, 0x0

    return v2
.end method

.method private static isValidGymLocation(Lorg/json/JSONObject;)Z
    .locals 7
    .param p0, "location"    # Lorg/json/JSONObject;

    .line 385
    const/4 v0, 0x0

    if-eqz p0, :cond_2

    const-string v1, "latitude"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "longitude"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    goto :goto_1

    .line 386
    :cond_0
    const-wide/high16 v3, 0x7ff8000000000000L    # Double.NaN

    invoke-virtual {p0, v1, v3, v4}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v5

    .line 387
    .local v5, "latitude":D
    invoke-virtual {p0, v2, v3, v4}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v1

    .line 388
    .local v1, "longitude":D
    invoke-static {v5, v6}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_1

    const-wide v3, -0x3fa9800000000000L    # -90.0

    cmpl-double v3, v5, v3

    if-ltz v3, :cond_1

    const-wide v3, 0x4056800000000000L    # 90.0

    cmpg-double v3, v5, v3

    if-gtz v3, :cond_1

    .line 389
    invoke-static {v1, v2}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_1

    const-wide v3, -0x3f99800000000000L    # -180.0

    cmpl-double v3, v1, v3

    if-ltz v3, :cond_1

    const-wide v3, 0x4066800000000000L    # 180.0

    cmpg-double v3, v1, v3

    if-gtz v3, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    nop

    .line 388
    :goto_0
    return v0

    .line 385
    .end local v1    # "longitude":D
    .end local v5    # "latitude":D
    :cond_2
    :goto_1
    return v0
.end method

.method private static jsonOrNull(Lorg/json/JSONObject;)Ljava/lang/Object;
    .locals 1
    .param p0, "value"    # Lorg/json/JSONObject;

    .line 478
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, p0

    goto :goto_1

    :cond_1
    :goto_0
    sget-object v0, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    :goto_1
    return-object v0
.end method

.method private synthetic lambda$registerGymGeofence$0(Ljava/lang/Void;)V
    .locals 1
    .param p1, "ignored"    # Ljava/lang/Void;

    .line 426
    const-string v0, ""

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    return-void
.end method

.method private synthetic lambda$registerGymGeofence$1(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "error"    # Ljava/lang/Exception;

    .line 427
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Android could not register the gym geofence: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 428
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 427
    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic lambda$removeGymGeofence$2(Ljava/lang/Exception;)V
    .locals 2
    .param p0, "error"    # Ljava/lang/Exception;

    .line 438
    const-string v0, "BLINK"

    const-string v1, "Could not remove gym geofence."

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method private mergeArray(Ljava/lang/String;Lorg/json/JSONArray;)V
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "incoming"    # Lorg/json/JSONArray;

    .line 364
    if-nez p2, :cond_0

    return-void

    .line 365
    :cond_0
    invoke-direct {p0, p1}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 366
    .local v0, "local":Lorg/json/JSONArray;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p2}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 367
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v2

    .line 368
    .local v2, "row":Lorg/json/JSONObject;
    if-eqz v2, :cond_1

    invoke-static {v0, v2}, Lcom/blink/app/TrackingStore;->addIfMissing(Lorg/json/JSONArray;Lorg/json/JSONObject;)V

    .line 366
    .end local v2    # "row":Lorg/json/JSONObject;
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 370
    .end local v1    # "i":I
    :cond_2
    iget-object v1, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, p1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 371
    return-void
.end method

.method private static parseObject(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 2
    .param p0, "value"    # Ljava/lang/String;

    .line 471
    if-eqz p0, :cond_1

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    :goto_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    return-object v0

    .line 472
    :catch_0
    move-exception v0

    .line 473
    .local v0, "error":Lorg/json/JSONException;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    return-object v1
.end method

.method private readObject(Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .line 466
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, ""

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blink/app/TrackingStore;->parseObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method private records(Ljava/lang/String;)Lorg/json/JSONArray;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .line 448
    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    iget-object v1, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v2, "[]"

    invoke-interface {v1, p1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 449
    .local v0, "array":Lorg/json/JSONArray;
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_1

    .line 450
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->opt(I)Ljava/lang/Object;

    move-result-object v2

    instance-of v2, v2, Lorg/json/JSONObject;

    if-nez v2, :cond_0

    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->remove(I)Ljava/lang/Object;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    .line 449
    :cond_0
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 452
    .end local v1    # "i":I
    :cond_1
    return-object v0

    .line 453
    .end local v0    # "array":Lorg/json/JSONArray;
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    .line 454
    .local v0, "error":Ljava/lang/Exception;
    :goto_1
    const-string v1, "Saved tracking history could not be read."

    invoke-virtual {p0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 455
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    return-object v1
.end method


# virtual methods
.method addDistance(D)V
    .locals 5
    .param p1, "distanceMeters"    # D

    .line 215
    const-string v0, "distanceMeters"

    invoke-direct {p0}, Lcom/blink/app/TrackingStore;->activeCardio()Lorg/json/JSONObject;

    move-result-object v1

    .line 216
    .local v1, "active":Lorg/json/JSONObject;
    if-eqz v1, :cond_1

    invoke-static {p1, p2}, Ljava/lang/Double;->isFinite(D)Z

    move-result v2

    if-eqz v2, :cond_1

    const-wide/16 v2, 0x0

    cmpg-double v4, p1, v2

    if-gtz v4, :cond_0

    goto :goto_1

    .line 218
    :cond_0
    :try_start_0
    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v2

    add-double/2addr v2, p1

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 219
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "active_cardio"

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 222
    goto :goto_0

    .line 220
    :catch_0
    move-exception v0

    .line 221
    .local v0, "error":Lorg/json/JSONException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not update cardio distance: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 223
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_0
    return-void

    .line 216
    :cond_1
    :goto_1
    return-void
.end method

.method checkGymWindow()V
    .locals 9

    .line 269
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "gym_inside"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 270
    .local v0, "inside":Z
    const-string v1, "active_gym"

    invoke-direct {p0, v1}, Lcom/blink/app/TrackingStore;->readObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 271
    .local v1, "active":Lorg/json/JSONObject;
    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/blink/app/TrackingStore;->isGymWindowOpen()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-nez v2, :cond_0

    .line 272
    const/4 v2, 0x1

    invoke-virtual {p0, v2}, Lcom/blink/app/TrackingStore;->setGymInside(Z)V

    goto :goto_1

    .line 273
    :cond_0
    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v2

    if-lez v2, :cond_2

    invoke-direct {p0}, Lcom/blink/app/TrackingStore;->isGymWindowOpen()Z

    move-result v2

    if-nez v2, :cond_2

    .line 274
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 276
    .local v2, "end":J
    :try_start_0
    const-string v4, "date"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/time/LocalDate;->parse(Ljava/lang/CharSequence;)Ljava/time/LocalDate;

    move-result-object v4

    .line 277
    .local v4, "sessionDate":Ljava/time/LocalDate;
    const/16 v5, 0x13

    const/16 v6, 0x1e

    invoke-virtual {v4, v5, v6}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v5

    invoke-static {}, Ljava/time/ZoneId;->systemDefault()Ljava/time/ZoneId;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v5

    invoke-virtual {v5}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v5

    invoke-virtual {v5}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v5

    .line 278
    .local v5, "windowEnd":J
    const-string v7, "startTime"

    invoke-virtual {v1, v7, v2, v3}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v7

    cmp-long v7, v5, v7

    if-ltz v7, :cond_1

    invoke-static {v2, v3, v5, v6}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v7
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-wide v2, v7

    .line 281
    .end local v4    # "sessionDate":Ljava/time/LocalDate;
    .end local v5    # "windowEnd":J
    :cond_1
    goto :goto_0

    .line 279
    :catch_0
    move-exception v4

    .line 280
    .local v4, "error":Ljava/lang/RuntimeException;
    const-string v5, "BLINK"

    const-string v6, "Could not determine the scheduled gym-session end time."

    invoke-static {v5, v6, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 282
    .end local v4    # "error":Ljava/lang/RuntimeException;
    :goto_0
    invoke-direct {p0, v1, v2, v3}, Lcom/blink/app/TrackingStore;->closeGymSession(Lorg/json/JSONObject;J)V

    .line 284
    .end local v2    # "end":J
    :cond_2
    :goto_1
    return-void
.end method

.method clearServiceError()V
    .locals 1

    .line 87
    const-string v0, ""

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 88
    return-void
.end method

.method consumeCardioStartRequested()Z
    .locals 3

    .line 116
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    const-string v2, "cardio_start_requested"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 117
    .local v0, "requested":Z
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 118
    :cond_0
    return v0
.end method

.method finishCardio()V
    .locals 21

    .line 156
    move-object/from16 v1, p0

    invoke-direct {v1}, Lcom/blink/app/TrackingStore;->activeCardio()Lorg/json/JSONObject;

    move-result-object v2

    .line 157
    .local v2, "active":Lorg/json/JSONObject;
    if-nez v2, :cond_0

    return-void

    .line 159
    :cond_0
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    .line 160
    .local v3, "end":J
    const-string v0, "startTime"

    invoke-virtual {v2, v0, v3, v4}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v5

    .line 161
    .local v5, "start":J
    const-string v0, "endTime"

    invoke-virtual {v2, v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 162
    const-string v0, "durationSeconds"

    sub-long v7, v3, v5

    long-to-double v7, v7

    const-wide v9, 0x408f400000000000L    # 1000.0

    div-double/2addr v7, v9

    const-wide/16 v11, 0x0

    invoke-static {v11, v12, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    invoke-virtual {v2, v0, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 163
    const-string v0, "distanceMeters"

    invoke-virtual {v2, v0, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v7

    invoke-static {v11, v12, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    .line 164
    .local v7, "meters":D
    sub-long v13, v3, v5

    long-to-double v13, v13

    div-double/2addr v13, v9

    invoke-static {v11, v12, v13, v14}, Ljava/lang/Math;->max(DD)D

    move-result-wide v13

    .line 165
    .local v13, "seconds":D
    const-string v0, "averageSpeedKmh"

    cmpl-double v15, v13, v11

    if-lez v15, :cond_1

    div-double v15, v7, v13

    const-wide v17, 0x400ccccccccccccdL    # 3.6

    mul-double v15, v15, v17

    move-wide/from16 v19, v15

    move-wide v15, v9

    move-wide/from16 v9, v19

    goto :goto_0

    :cond_1
    move-wide v15, v9

    move-wide v9, v11

    :goto_0
    invoke-virtual {v2, v0, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 166
    const-string v0, "paceMinutesPerKm"

    cmpl-double v9, v7, v11

    if-lez v9, :cond_2

    const-wide/high16 v9, 0x404e000000000000L    # 60.0

    div-double v9, v13, v9

    div-double v15, v7, v15

    div-double/2addr v9, v15

    invoke-static {v9, v10}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v9

    goto :goto_1

    :cond_2
    sget-object v9, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    :goto_1
    invoke-virtual {v2, v0, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 167
    const-string v0, "movementType"

    const-string v9, "runningSeconds"

    invoke-virtual {v2, v9, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v9

    const-string v15, "walkingSeconds"

    invoke-virtual {v2, v15, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v11

    cmpl-double v9, v9, v11

    if-lez v9, :cond_3

    .line 168
    const-string v9, "running"

    goto :goto_2

    :cond_3
    const-string v9, "walking"

    .line 167
    :goto_2
    invoke-virtual {v2, v0, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 169
    const-string v0, "cardio_records"

    invoke-direct {v1, v0, v2}, Lcom/blink/app/TrackingStore;->appendRecord(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 170
    iget-object v0, v1, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v9, "active_cardio"

    invoke-interface {v0, v9}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 171
    const-string v0, ""

    invoke-virtual {v1, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 174
    .end local v3    # "end":J
    .end local v5    # "start":J
    .end local v7    # "meters":D
    .end local v13    # "seconds":D
    goto :goto_3

    .line 172
    :catch_0
    move-exception v0

    .line 173
    .local v0, "error":Lorg/json/JSONException;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Could not save the cardio session: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 175
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_3
    return-void
.end method

.method hasActiveCardio()Z
    .locals 3

    .line 144
    :try_start_0
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "active_cardio"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    xor-int/lit8 v0, v0, 0x1

    return v0

    .line 145
    :catch_0
    move-exception v0

    .line 146
    .local v0, "error":Ljava/lang/ClassCastException;
    const-string v1, "Saved cardio state could not be read."

    invoke-virtual {p0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 147
    const/4 v1, 0x0

    return v1
.end method

.method hasGymLocation()Z
    .locals 3

    .line 59
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "gym_location"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blink/app/TrackingStore;->parseObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {v0}, Lcom/blink/app/TrackingStore;->isValidGymLocation(Lorg/json/JSONObject;)Z

    move-result v0

    return v0
.end method

.method isActivityTrackingEnabled()Z
    .locals 3

    .line 47
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "activity_enabled"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method isGymDetectionEnabled()Z
    .locals 3

    .line 51
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "gym_enabled"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method isLocationTrackingEnabled()Z
    .locals 1

    iget-object v0, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/blink/app/LocationSchedule;->shouldTrackNow(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method isSleepEstimationEnabled()Z
    .locals 3

    .line 55
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "sleep_enabled"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method mergeCloudRecords(Lorg/json/JSONObject;Lorg/json/JSONObject;Lorg/json/JSONObject;)V
    .locals 5
    .param p1, "cardio"    # Lorg/json/JSONObject;
    .param p2, "gym"    # Lorg/json/JSONObject;
    .param p3, "sleep"    # Lorg/json/JSONObject;

    .line 339
    const-string v0, "sessions"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    const-string v2, "cardio_records"

    invoke-direct {p0, v2, v1}, Lcom/blink/app/TrackingStore;->mergeArray(Ljava/lang/String;Lorg/json/JSONArray;)V

    .line 340
    const-string v1, "gym_records"

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    invoke-direct {p0, v1, v0}, Lcom/blink/app/TrackingStore;->mergeArray(Ljava/lang/String;Lorg/json/JSONArray;)V

    .line 341
    const-string v0, "estimates"

    invoke-virtual {p3, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 342
    .local v0, "estimates":Lorg/json/JSONArray;
    if-nez v0, :cond_0

    return-void

    .line 343
    :cond_0
    const-string v1, "sleep_estimates"

    invoke-direct {p0, v1}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 344
    .local v2, "local":Lorg/json/JSONArray;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v3, v4, :cond_2

    .line 345
    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 346
    .local v4, "row":Lorg/json/JSONObject;
    if-eqz v4, :cond_1

    invoke-static {v2, v4}, Lcom/blink/app/TrackingStore;->addIfMissing(Lorg/json/JSONArray;Lorg/json/JSONObject;)V

    .line 344
    .end local v4    # "row":Lorg/json/JSONObject;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 348
    .end local v3    # "i":I
    :cond_2
    iget-object v3, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-virtual {v2}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v1, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 349
    return-void
.end method

.method recordLocation(DDFFJ)V
    .locals 26
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "accuracyMeters"    # F
    .param p6, "speedMps"    # F
    .param p7, "timestamp"    # J

    .line 178
    move-object/from16 v1, p0

    move/from16 v2, p6

    move-wide/from16 v3, p7

    const-string v0, "lastSpeedMps"

    const-string v5, "lastSampleTime"

    invoke-direct {v1}, Lcom/blink/app/TrackingStore;->activeCardio()Lorg/json/JSONObject;

    move-result-object v6

    .line 179
    .local v6, "active":Lorg/json/JSONObject;
    if-nez v6, :cond_0

    return-void

    .line 181
    :cond_0
    const-wide/16 v7, 0x0

    :try_start_0
    invoke-virtual {v6, v5, v7, v8}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v9

    .line 182
    .local v9, "previous":J
    const-wide/16 v11, 0x0

    invoke-virtual {v6, v0, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v13

    .line 183
    .local v13, "previousSpeed":D
    cmp-long v7, v9, v7

    move-wide v15, v11

    const-wide/high16 v11, 0x4024000000000000L    # 10.0

    if-lez v7, :cond_6

    .line 184
    sub-long v7, v3, v9

    long-to-double v7, v7

    const-wide v17, 0x408f400000000000L    # 1000.0

    div-double v7, v7, v17

    .line 185
    .local v7, "elapsedSeconds":D
    cmpl-double v17, v7, v15

    if-lez v17, :cond_5

    const-wide/high16 v17, 0x403e000000000000L    # 30.0

    cmpg-double v17, v7, v17

    if-gtz v17, :cond_5

    .line 186
    move-wide/from16 v17, v9

    .end local v9    # "previous":J
    .local v17, "previous":J
    float-to-double v9, v2

    invoke-static {v9, v10, v11, v12}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    move-wide v11, v15

    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_3

    .line 187
    .local v9, "speed":D
    const-wide v11, 0x3fe199999999999aL    # 0.55

    cmpl-double v19, v9, v11

    const-wide/high16 v20, 0x4000000000000000L    # 2.0

    move-wide/from16 v22, v11

    const-string v11, "runningSeconds"

    const-string v12, "walkingSeconds"

    if-ltz v19, :cond_2

    .line 188
    cmpl-double v19, v9, v20

    if-ltz v19, :cond_1

    .line 189
    move-wide/from16 v24, v9

    const-wide/16 v9, 0x0

    .end local v9    # "speed":D
    .local v24, "speed":D
    :try_start_1
    invoke-virtual {v6, v11, v9, v10}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v19

    add-double v9, v19, v7

    invoke-virtual {v6, v11, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_0

    .line 191
    .end local v24    # "speed":D
    .restart local v9    # "speed":D
    :cond_1
    move-wide/from16 v24, v9

    .end local v9    # "speed":D
    .restart local v24    # "speed":D
    const-wide/16 v9, 0x0

    invoke-virtual {v6, v12, v9, v10}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v19

    add-double v9, v19, v7

    invoke-virtual {v6, v12, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_0

    .line 193
    .end local v24    # "speed":D
    .restart local v9    # "speed":D
    :cond_2
    move-wide/from16 v24, v9

    .end local v9    # "speed":D
    .restart local v24    # "speed":D
    cmpl-double v9, v13, v22

    if-ltz v9, :cond_4

    .line 194
    const-wide/high16 v9, 0x4018000000000000L    # 6.0

    invoke-static {v7, v8, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    .line 195
    .local v9, "bounded":D
    cmpl-double v19, v13, v20

    if-ltz v19, :cond_3

    .line 196
    move-wide/from16 v19, v7

    const-wide/16 v7, 0x0

    .end local v7    # "elapsedSeconds":D
    .local v19, "elapsedSeconds":D
    invoke-virtual {v6, v11, v7, v8}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v21

    add-double v7, v21, v9

    invoke-virtual {v6, v11, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_0

    .line 198
    .end local v19    # "elapsedSeconds":D
    .restart local v7    # "elapsedSeconds":D
    :cond_3
    move-wide/from16 v19, v7

    .end local v7    # "elapsedSeconds":D
    .restart local v19    # "elapsedSeconds":D
    const-wide/16 v7, 0x0

    invoke-virtual {v6, v12, v7, v8}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v21

    add-double v7, v21, v9

    invoke-virtual {v6, v12, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_0

    .line 193
    .end local v9    # "bounded":D
    .end local v19    # "elapsedSeconds":D
    .restart local v7    # "elapsedSeconds":D
    :cond_4
    move-wide/from16 v19, v7

    .end local v7    # "elapsedSeconds":D
    .restart local v19    # "elapsedSeconds":D
    goto :goto_0

    .line 185
    .end local v17    # "previous":J
    .end local v19    # "elapsedSeconds":D
    .end local v24    # "speed":D
    .restart local v7    # "elapsedSeconds":D
    .local v9, "previous":J
    :cond_5
    move-wide/from16 v19, v7

    move-wide/from16 v17, v9

    .end local v7    # "elapsedSeconds":D
    .end local v9    # "previous":J
    .restart local v17    # "previous":J
    .restart local v19    # "elapsedSeconds":D
    goto :goto_0

    .line 183
    .end local v17    # "previous":J
    .end local v19    # "elapsedSeconds":D
    .restart local v9    # "previous":J
    :cond_6
    move-wide/from16 v17, v9

    .line 203
    .end local v9    # "previous":J
    .restart local v17    # "previous":J
    :goto_0
    invoke-virtual {v6, v5, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 204
    float-to-double v7, v2

    const-wide/high16 v9, 0x4024000000000000L    # 10.0

    invoke-static {v7, v8, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v7

    const-wide/16 v9, 0x0

    invoke-static {v9, v10, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    invoke-virtual {v6, v0, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 205
    const-string v0, "lastLatitude"
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_3

    move-wide/from16 v7, p1

    :try_start_2
    invoke-virtual {v6, v0, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 206
    const-string v0, "lastLongitude"
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    move-wide/from16 v9, p3

    :try_start_3
    invoke-virtual {v6, v0, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 207
    const-string v0, "lastAccuracyMeters"
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_1

    move/from16 v5, p5

    float-to-double v11, v5

    :try_start_4
    invoke-virtual {v6, v0, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 208
    iget-object v0, v1, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v11, "active_cardio"

    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-interface {v0, v11, v12}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_0

    .line 211
    .end local v13    # "previousSpeed":D
    .end local v17    # "previous":J
    goto :goto_4

    .line 209
    :catch_0
    move-exception v0

    goto :goto_3

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_1

    :catch_3
    move-exception v0

    move-wide/from16 v7, p1

    :goto_1
    move-wide/from16 v9, p3

    :goto_2
    move/from16 v5, p5

    .line 210
    .local v0, "error":Lorg/json/JSONException;
    :goto_3
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Could not update cardio activity: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v1, v11}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 212
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_4
    return-void
.end method

.method recordStep()V
    .locals 7

    .line 226
    const-string v0, "steps"

    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1}, Ljava/time/LocalDate;->toString()Ljava/lang/String;

    move-result-object v1

    .line 227
    .local v1, "date":Ljava/lang/String;
    const-string v2, "steps_by_day"

    invoke-direct {p0, v2}, Lcom/blink/app/TrackingStore;->readObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    .line 229
    .local v3, "days":Lorg/json/JSONObject;
    const/4 v4, 0x0

    :try_start_0
    invoke-virtual {v3, v1, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v5

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v3, v1, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 230
    iget-object v5, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v5, v2, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1

    .line 234
    nop

    .line 235
    invoke-direct {p0}, Lcom/blink/app/TrackingStore;->activeCardio()Lorg/json/JSONObject;

    move-result-object v2

    .line 236
    .local v2, "active":Lorg/json/JSONObject;
    if-nez v2, :cond_0

    return-void

    .line 238
    :cond_0
    :try_start_1
    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 239
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v4, "active_cardio"

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    .line 242
    goto :goto_0

    .line 240
    :catch_0
    move-exception v0

    .line 241
    .local v0, "error":Lorg/json/JSONException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Could not update the cardio step count: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 243
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_0
    return-void

    .line 231
    .end local v2    # "active":Lorg/json/JSONObject;
    :catch_1
    move-exception v0

    .line 232
    .restart local v0    # "error":Lorg/json/JSONException;
    const-string v2, "Could not save step sensor activity."

    invoke-virtual {p0, v2}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 233
    return-void
.end method

.method registerGymGeofence(Landroid/content/Context;Lcom/google/android/gms/location/GeofencingClient;)V
    .locals 13
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "client"    # Lcom/google/android/gms/location/GeofencingClient;

    .line 393
    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 394
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_1

    .line 395
    const-string v0, "android.permission.ACCESS_BACKGROUND_LOCATION"

    invoke-static {p1, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    .line 397
    const-string v0, "Allow background location to enable gym geofencing while BLINK is closed."

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 398
    return-void

    .line 400
    :cond_1
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "gym_location"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blink/app/TrackingStore;->parseObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 401
    .local v1, "location":Lorg/json/JSONObject;
    invoke-static {v1}, Lcom/blink/app/TrackingStore;->isValidGymLocation(Lorg/json/JSONObject;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 402
    const-string v0, "Gym location not configured. Choose and save valid coordinates before enabling geofencing."

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 403
    return-void

    .line 405
    :cond_2
    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    invoke-static {p1, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_3

    .line 407
    const-string v0, "Precise location permission is required before enabling gym geofencing."

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 408
    return-void

    .line 411
    :cond_3
    :try_start_0
    const-string v0, "latitude"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v2

    move-wide v5, v2

    .line 412
    .local v5, "latitude":D
    const-string v0, "longitude"

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v7

    .line 413
    .local v7, "longitude":D
    const-string v0, "radiusMeters"

    const-wide/high16 v2, 0x405e000000000000L    # 120.0

    invoke-virtual {v1, v0, v2, v3}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v2

    .line 414
    .local v2, "radiusMeters":D
    invoke-static {v2, v3}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_4

    const-wide/16 v9, 0x0

    cmpg-double v0, v2, v9

    if-gtz v0, :cond_5

    :cond_4
    const-wide/high16 v2, 0x405e000000000000L    # 120.0

    .line 415
    :cond_5
    new-instance v0, Lcom/google/android/gms/location/Geofence$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/location/Geofence$Builder;-><init>()V

    const-string v4, "blink-gym"

    .line 416
    invoke-virtual {v0, v4}, Lcom/google/android/gms/location/Geofence$Builder;->setRequestId(Ljava/lang/String;)Lcom/google/android/gms/location/Geofence$Builder;

    move-result-object v4

    .line 417
    const-wide v9, 0x407f400000000000L    # 500.0

    invoke-static {v9, v10, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    const-wide/high16 v11, 0x4049000000000000L    # 50.0

    invoke-static {v11, v12, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9

    double-to-float v9, v9

    invoke-virtual/range {v4 .. v9}, Lcom/google/android/gms/location/Geofence$Builder;->setCircularRegion(DDF)Lcom/google/android/gms/location/Geofence$Builder;

    move-result-object v0

    .line 418
    const/4 v4, 0x3

    invoke-virtual {v0, v4}, Lcom/google/android/gms/location/Geofence$Builder;->setTransitionTypes(I)Lcom/google/android/gms/location/Geofence$Builder;

    move-result-object v0

    .line 419
    const-wide/16 v9, -0x1

    invoke-virtual {v0, v9, v10}, Lcom/google/android/gms/location/Geofence$Builder;->setExpirationDuration(J)Lcom/google/android/gms/location/Geofence$Builder;

    move-result-object v0

    .line 420
    invoke-virtual {v0}, Lcom/google/android/gms/location/Geofence$Builder;->build()Lcom/google/android/gms/location/Geofence;

    move-result-object v0

    .line 421
    .local v0, "fence":Lcom/google/android/gms/location/Geofence;
    new-instance v4, Lcom/google/android/gms/location/GeofencingRequest$Builder;

    invoke-direct {v4}, Lcom/google/android/gms/location/GeofencingRequest$Builder;-><init>()V

    .line 422
    const/4 v9, 0x1

    invoke-virtual {v4, v9}, Lcom/google/android/gms/location/GeofencingRequest$Builder;->setInitialTrigger(I)Lcom/google/android/gms/location/GeofencingRequest$Builder;

    move-result-object v4

    .line 423
    invoke-virtual {v4, v0}, Lcom/google/android/gms/location/GeofencingRequest$Builder;->addGeofence(Lcom/google/android/gms/location/Geofence;)Lcom/google/android/gms/location/GeofencingRequest$Builder;

    move-result-object v4

    .line 424
    invoke-virtual {v4}, Lcom/google/android/gms/location/GeofencingRequest$Builder;->build()Lcom/google/android/gms/location/GeofencingRequest;

    move-result-object v4

    .line 425
    .local v4, "request":Lcom/google/android/gms/location/GeofencingRequest;
    invoke-static {p1}, Lcom/blink/app/GymGeofenceReceiver;->pendingIntent(Landroid/content/Context;)Landroid/app/PendingIntent;

    move-result-object v9

    invoke-interface {p2, v4, v9}, Lcom/google/android/gms/location/GeofencingClient;->addGeofences(Lcom/google/android/gms/location/GeofencingRequest;Landroid/app/PendingIntent;)Lcom/google/android/gms/tasks/Task;

    move-result-object v9

    new-instance v10, Lcom/blink/app/TrackingStore$$ExternalSyntheticLambda1;

    invoke-direct {v10, p0}, Lcom/blink/app/TrackingStore$$ExternalSyntheticLambda1;-><init>(Lcom/blink/app/TrackingStore;)V

    .line 426
    invoke-virtual {v9, v10}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    move-result-object v9

    new-instance v10, Lcom/blink/app/TrackingStore$$ExternalSyntheticLambda2;

    invoke-direct {v10, p0}, Lcom/blink/app/TrackingStore$$ExternalSyntheticLambda2;-><init>(Lcom/blink/app/TrackingStore;)V

    .line 427
    invoke-virtual {v9, v10}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;

    .line 429
    invoke-static {p1}, Lcom/blink/app/GymGeofenceReceiver;->scheduleNextWindow(Landroid/content/Context;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 432
    .end local v0    # "fence":Lcom/google/android/gms/location/Geofence;
    .end local v2    # "radiusMeters":D
    .end local v4    # "request":Lcom/google/android/gms/location/GeofencingRequest;
    .end local v5    # "latitude":D
    .end local v7    # "longitude":D
    goto :goto_1

    .line 430
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 431
    .local v0, "error":Ljava/lang/Exception;
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not register the gym geofence: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 434
    .end local v0    # "error":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method removeGymGeofence(Lcom/google/android/gms/location/GeofencingClient;)V
    .locals 2
    .param p1, "client"    # Lcom/google/android/gms/location/GeofencingClient;

    .line 437
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/blink/app/GymGeofenceReceiver;->pendingIntent(Landroid/content/Context;)Landroid/app/PendingIntent;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/google/android/gms/location/GeofencingClient;->removeGeofences(Landroid/app/PendingIntent;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    new-instance v1, Lcom/blink/app/TrackingStore$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/blink/app/TrackingStore$$ExternalSyntheticLambda0;-><init>()V

    .line 438
    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;

    .line 439
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/blink/app/GymGeofenceReceiver;->cancelWindow(Landroid/content/Context;)V

    .line 440
    return-void
.end method

.method saveSleepEstimate(Lorg/json/JSONObject;)V
    .locals 4
    .param p1, "estimate"    # Lorg/json/JSONObject;

    .line 352
    if-eqz p1, :cond_1

    const-string v0, "date"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 353
    :cond_0
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "sleep_estimate"

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 354
    const-string v0, "sleep_estimates"

    invoke-direct {p0, v0}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    .line 355
    .local v1, "all":Lorg/json/JSONArray;
    invoke-static {v1, p1}, Lcom/blink/app/TrackingStore;->addIfMissing(Lorg/json/JSONArray;Lorg/json/JSONObject;)V

    .line 356
    iget-object v2, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v0, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 357
    return-void

    .line 352
    .end local v1    # "all":Lorg/json/JSONArray;
    :cond_1
    :goto_0
    return-void
.end method

.method setCardioStartRequested(Z)V
    .locals 2
    .param p1, "requested"    # Z

    .line 112
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "cardio_start_requested"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 113
    return-void
.end method

.method setGymDetectionEnabled(Z)V
    .locals 2
    .param p1, "enabled"    # Z

    .line 79
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "gym_enabled"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 80
    if-nez p1, :cond_0

    .line 81
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setGymInside(Z)V

    .line 82
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/blink/app/TrackingStore$LocationServicesProvider;->client(Landroid/content/Context;)Lcom/google/android/gms/location/GeofencingClient;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->removeGymGeofence(Lcom/google/android/gms/location/GeofencingClient;)V

    .line 84
    :cond_0
    return-void
.end method

.method setGymInside(Z)V
    .locals 6
    .param p1, "inside"    # Z

    .line 250
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "gym_inside"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 251
    const-string v0, "active_gym"

    invoke-direct {p0, v0}, Lcom/blink/app/TrackingStore;->readObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 252
    .local v1, "active":Lorg/json/JSONObject;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 253
    .local v2, "now":J
    if-eqz p1, :cond_0

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v4

    if-nez v4, :cond_0

    invoke-direct {p0}, Lcom/blink/app/TrackingStore;->isGymWindowOpen()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 255
    :try_start_0
    const-string v4, "id"

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 256
    const-string v4, "startTime"

    invoke-virtual {v1, v4, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 257
    const-string v4, "date"

    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v5

    invoke-virtual {v5}, Ljava/time/LocalDate;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 258
    const-string v4, "status"

    const-string v5, "At Gym"

    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 259
    iget-object v4, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v0, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 260
    :catch_0
    move-exception v0

    .line 261
    .local v0, "error":Lorg/json/JSONException;
    const-string v4, "Could not save the gym presence session."

    invoke-virtual {p0, v4}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 262
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_0
    goto :goto_1

    .line 263
    :cond_0
    if-nez p1, :cond_1

    invoke-virtual {v1}, Lorg/json/JSONObject;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 264
    invoke-direct {p0, v1, v2, v3}, Lcom/blink/app/TrackingStore;->closeGymSession(Lorg/json/JSONObject;J)V

    .line 266
    :cond_1
    :goto_1
    return-void
.end method

.method setGymLocation(DDF)V
    .locals 6
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F

    .line 91
    invoke-static {p1, p2}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_1

    const-wide v0, -0x3fa9800000000000L    # -90.0

    cmpg-double v0, p1, v0

    if-ltz v0, :cond_1

    const-wide v0, 0x4056800000000000L    # 90.0

    cmpl-double v0, p1, v0

    if-gtz v0, :cond_1

    .line 92
    invoke-static {p3, p4}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_1

    const-wide v0, -0x3f99800000000000L    # -180.0

    cmpg-double v0, p3, v0

    if-ltz v0, :cond_1

    const-wide v0, 0x4066800000000000L    # 180.0

    cmpl-double v0, p3, v0

    if-gtz v0, :cond_1

    .line 93
    invoke-static {p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 98
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "gym_location"

    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    const-string v3, "latitude"

    .line 100
    invoke-virtual {v2, v3, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "longitude"

    .line 101
    invoke-virtual {v2, v3, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "radiusMeters"

    .line 102
    const/high16 v4, 0x43fa0000    # 500.0f

    invoke-static {v4, p5}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const/high16 v5, 0x42480000    # 50.0f

    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    float-to-double v4, v4

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    move-result-object v2

    .line 103
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    .line 99
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 104
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 105
    const-string v0, ""

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 108
    goto :goto_0

    .line 106
    :catch_0
    move-exception v0

    .line 107
    .local v0, "error":Lorg/json/JSONException;
    const-string v1, "Could not save the selected gym location."

    invoke-virtual {p0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 109
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_0
    return-void

    .line 94
    :cond_1
    :goto_1
    const-string v0, "The selected gym location is invalid."

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 95
    return-void
.end method

.method setServiceError(Ljava/lang/String;)V
    .locals 3
    .param p1, "error"    # Ljava/lang/String;

    .line 246
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    if-nez p1, :cond_0

    const-string v1, ""

    goto :goto_0

    :cond_0
    move-object v1, p1

    :goto_0
    const-string v2, "service_error"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 247
    return-void
.end method

.method setServiceRunning(Z)V
    .locals 2
    .param p1, "running"    # Z

    .line 152
    iget-object v0, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "service_running"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 153
    return-void
.end method

.method setTrackingSettings(ZZZZD)V
    .locals 6
    .param p1, "location"    # Z
    .param p2, "activity"    # Z
    .param p3, "gym"    # Z
    .param p4, "sleep"    # Z
    .param p5, "target"    # D

    .line 63
    move v1, p1

    .line 64
    invoke-static {p5, p6}, Ljava/lang/Double;->isFinite(D)Z

    move-result p1

    if-eqz p1, :cond_0

    const-wide/high16 v2, 0x402c000000000000L    # 14.0

    invoke-static {v2, v3, p5, p6}, Ljava/lang/Math;->min(DD)D

    move-result-wide v2

    const-wide/high16 v4, 0x4010000000000000L    # 4.0

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v2

    goto :goto_0

    :cond_0
    const-wide/high16 v2, 0x4020000000000000L    # 8.0

    .line 65
    .local v2, "safeTarget":D
    :goto_0
    iget-object p1, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 66
    const-string v4, "location_enabled"

    invoke-interface {p1, v4, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 67
    const-string v4, "activity_enabled"

    invoke-interface {p1, v4, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 68
    const-string v4, "gym_enabled"

    invoke-interface {p1, v4, p3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 69
    const-string v4, "sleep_enabled"

    invoke-interface {p1, v4, p4}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    double-to-float v4, v2

    .line 70
    const-string v5, "sleep_target"

    invoke-interface {p1, v5, v4}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 71
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 72
    if-nez p3, :cond_1

    .line 73
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/blink/app/TrackingStore;->setGymInside(Z)V

    .line 74
    iget-object p1, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    invoke-static {p1}, Lcom/blink/app/TrackingStore$LocationServicesProvider;->client(Landroid/content/Context;)Lcom/google/android/gms/location/GeofencingClient;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/blink/app/TrackingStore;->removeGymGeofence(Lcom/google/android/gms/location/GeofencingClient;)V

    .line 76
    :cond_1
    return-void
.end method

.method sleepEstimates()Lorg/json/JSONArray;
    .locals 1

    .line 360
    const-string v0, "sleep_estimates"

    invoke-direct {p0, v0}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method

.method startCardio()V
    .locals 9

    .line 122
    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->hasActiveCardio()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 123
    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 125
    .local v0, "session":Lorg/json/JSONObject;
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    .line 126
    .local v1, "now":J
    const-string v3, "id"

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 127
    const-string v3, "startTime"

    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 128
    const-string v3, "date"

    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v4

    invoke-virtual {v4}, Ljava/time/LocalDate;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 129
    const-string v3, "distanceMeters"

    const-wide/16 v4, 0x0

    invoke-virtual {v0, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 130
    const-string v3, "steps"

    const/4 v6, 0x0

    invoke-virtual {v0, v3, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 131
    const-string v3, "walkingSeconds"

    invoke-virtual {v0, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 132
    const-string v3, "runningSeconds"

    invoke-virtual {v0, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 133
    const-string v3, "lastSampleTime"

    const-wide/16 v7, 0x0

    invoke-virtual {v0, v3, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 134
    const-string v3, "lastSpeedMps"

    invoke-virtual {v0, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 135
    iget-object v3, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "active_cardio"

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "cardio_start_requested"

    .line 136
    invoke-interface {v3, v4, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 139
    .end local v1    # "now":J
    goto :goto_0

    .line 137
    :catch_0
    move-exception v1

    .line 138
    .local v1, "error":Lorg/json/JSONException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not start a cardio session: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 140
    .end local v1    # "error":Lorg/json/JSONException;
    :goto_0
    return-void
.end method

.method stateJson(ZZZ)Lorg/json/JSONObject;
    .locals 8
    .param p1, "preciseLocation"    # Z
    .param p2, "backgroundLocation"    # Z
    .param p3, "usageAccess"    # Z

    .line 304
    const-string v0, ""

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 306
    .local v1, "state":Lorg/json/JSONObject;
    :try_start_0
    const-string v2, "locationEnabled"

    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->isLocationTrackingEnabled()Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v2, "manualLocationEnabled"

    iget-object v3, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v4, "location_enabled"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v2, "scheduleEnabled"

    iget-object v3, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/blink/app/LocationSchedule;->isEnabled(Landroid/content/Context;)Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 307
    const-string v2, "activityEnabled"

    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->isActivityTrackingEnabled()Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 308
    const-string v2, "gymEnabled"

    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 309
    const-string v2, "sleepEnabled"

    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->isSleepEstimationEnabled()Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 310
    const-string v2, "serviceRunning"

    iget-object v3, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v4, "service_running"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 311
    const-string v2, "preciseLocationGranted"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 312
    const-string v2, "backgroundLocationGranted"

    invoke-virtual {v1, v2, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 313
    const-string v2, "activityPermissionGranted"

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1d

    const/4 v6, 0x1

    if-lt v3, v4, :cond_1

    iget-object v3, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    const-string v4, "android.permission.ACTIVITY_RECOGNITION"

    .line 314
    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_0

    goto :goto_0

    :cond_0
    move v3, v5

    goto :goto_1

    :cond_1
    :goto_0
    move v3, v6

    .line 313
    :goto_1
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 316
    iget-object v2, p0, Lcom/blink/app/TrackingStore;->context:Landroid/content/Context;

    const-string v3, "sensor"

    .line 317
    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/hardware/SensorManager;

    .line 318
    .local v2, "sensors":Landroid/hardware/SensorManager;
    const-string v3, "stepSensorAvailable"

    if-eqz v2, :cond_2

    .line 319
    const/16 v4, 0x12

    invoke-virtual {v2, v4}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v4

    if-eqz v4, :cond_2

    goto :goto_2

    :cond_2
    move v6, v5

    .line 318
    :goto_2
    invoke-virtual {v1, v3, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 320
    const-string v3, "usageAccessGranted"

    invoke-virtual {v1, v3, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 321
    const-string v3, "sleepTargetHours"

    iget-object v4, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v6, "sleep_target"

    const/high16 v7, 0x41000000    # 8.0f

    invoke-interface {v4, v6, v7}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v4

    float-to-double v6, v4

    invoke-virtual {v1, v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 322
    const-string v3, "serviceError"

    iget-object v4, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v6, "service_error"

    invoke-interface {v4, v6, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 323
    const-string v3, "activeCardio"

    invoke-direct {p0}, Lcom/blink/app/TrackingStore;->activeCardio()Lorg/json/JSONObject;

    move-result-object v4

    invoke-static {v4}, Lcom/blink/app/TrackingStore;->jsonOrNull(Lorg/json/JSONObject;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 324
    const-string v3, "cardioSessions"

    const-string v4, "cardio_records"

    invoke-direct {p0, v4}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 325
    const-string v3, "stepsByDay"

    const-string v4, "steps_by_day"

    invoke-direct {p0, v4}, Lcom/blink/app/TrackingStore;->readObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 326
    const-string v3, "gymLocation"

    iget-object v4, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v6, "gym_location"

    invoke-interface {v4, v6, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/blink/app/TrackingStore;->parseObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 327
    const-string v3, "gymInside"

    iget-object v4, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v6, "gym_inside"

    invoke-interface {v4, v6, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 328
    const-string v3, "activeGymSession"

    const-string v4, "active_gym"

    invoke-direct {p0, v4}, Lcom/blink/app/TrackingStore;->readObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    invoke-static {v4}, Lcom/blink/app/TrackingStore;->jsonOrNull(Lorg/json/JSONObject;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 329
    const-string v3, "gymSessions"

    const-string v4, "gym_records"

    invoke-direct {p0, v4}, Lcom/blink/app/TrackingStore;->records(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 330
    const-string v3, "sleepEstimate"

    iget-object v4, p0, Lcom/blink/app/TrackingStore;->prefs:Landroid/content/SharedPreferences;

    const-string v5, "sleep_estimate"

    invoke-interface {v4, v5, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/blink/app/TrackingStore;->parseObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v1, v3, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 331
    const-string v0, "sleepEstimates"

    invoke-virtual {p0}, Lcom/blink/app/TrackingStore;->sleepEstimates()Lorg/json/JSONArray;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 334
    nop

    .end local v2    # "sensors":Landroid/hardware/SensorManager;
    goto :goto_3

    .line 332
    :catch_0
    move-exception v0

    .line 333
    .local v0, "error":Lorg/json/JSONException;
    const-string v2, "BLINK"

    const-string v3, "Could not serialize tracking state."

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 335
    .end local v0    # "error":Lorg/json/JSONException;
    :goto_3
    return-object v1
.end method
