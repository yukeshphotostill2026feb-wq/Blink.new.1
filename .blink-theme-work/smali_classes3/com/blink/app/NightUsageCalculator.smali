.class final Lcom/blink/app/NightUsageCalculator;
.super Ljava/lang/Object;
.source "NightUsageCalculator.java"


# static fields
.field private static final ACTIVITY_DESTROYED:I = 0x18

.field private static final ACTIVITY_PAUSED:I = 0x2

.field private static final ACTIVITY_RESUMED:I = 0x1

.field private static final ACTIVITY_STOPPED:I = 0x17

.field private static final RECOVERY_WINDOW_MILLIS:J = 0x19bfcc0L


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    return-void
.end method

.method static calculate(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 20
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 23
    nop

    .line 24
    const-string v0, "usagestats"

    move-object/from16 v1, p0

    invoke-virtual {v1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/usage/UsageStatsManager;

    .line 25
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 26
    return-object v1

    .line 29
    :cond_0
    invoke-static {}, Ljava/time/ZoneId;->systemDefault()Ljava/time/ZoneId;

    move-result-object v2

    .line 30
    invoke-static {v2}, Ljava/time/LocalDate;->now(Ljava/time/ZoneId;)Ljava/time/LocalDate;

    move-result-object v3

    .line 31
    const-wide/16 v4, 0x1

    invoke-virtual {v3, v4, v5}, Ljava/time/LocalDate;->minusDays(J)Ljava/time/LocalDate;

    move-result-object v4

    const/4 v5, 0x0

    const/16 v6, 0x17

    invoke-virtual {v4, v6, v5}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v4

    .line 32
    invoke-virtual {v4}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v4

    invoke-virtual {v4}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v4

    .line 33
    const/4 v7, 0x6

    const/16 v8, 0x1e

    invoke-virtual {v3, v7, v8}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v2

    invoke-virtual {v2}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v2

    invoke-virtual {v2}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v7

    .line 34
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    cmp-long v2, v9, v7

    if-gez v2, :cond_1

    .line 35
    return-object v1

    .line 38
    :cond_1
    const-wide/32 v9, 0x5265c00

    sub-long v9, v4, v9

    .line 39
    invoke-virtual {v0, v9, v10, v7, v8}, Landroid/app/usage/UsageStatsManager;->queryEvents(JJ)Landroid/app/usage/UsageEvents;

    move-result-object v0

    .line 40
    if-nez v0, :cond_2

    .line 41
    return-object v1

    .line 44
    :cond_2
    new-instance v2, Landroid/app/usage/UsageEvents$Event;

    invoke-direct {v2}, Landroid/app/usage/UsageEvents$Event;-><init>()V

    .line 45
    nop

    .line 46
    nop

    .line 47
    move-object v11, v1

    const-wide/16 v12, 0x0

    const-wide/16 v14, 0x0

    .line 48
    :goto_0
    invoke-virtual {v0}, Landroid/app/usage/UsageEvents;->hasNextEvent()Z

    move-result v16

    const/4 v1, 0x1

    if-eqz v16, :cond_8

    .line 49
    invoke-virtual {v0, v2}, Landroid/app/usage/UsageEvents;->getNextEvent(Landroid/app/usage/UsageEvents$Event;)Z

    .line 50
    invoke-virtual {v2}, Landroid/app/usage/UsageEvents$Event;->getEventType()I

    move-result v6

    .line 51
    invoke-virtual {v2}, Landroid/app/usage/UsageEvents$Event;->getPackageName()Ljava/lang/String;

    move-result-object v9

    .line 52
    move-object/from16 v17, v9

    invoke-virtual {v2}, Landroid/app/usage/UsageEvents$Event;->getTimeStamp()J

    move-result-wide v9

    .line 54
    if-ne v6, v1, :cond_4

    .line 55
    if-eqz v11, :cond_3

    .line 56
    nop

    .line 57
    invoke-static {v7, v8, v9, v10}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v18

    invoke-static {v4, v5, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v14

    sub-long v14, v18, v14

    .line 56
    move-object/from16 v18, v0

    const-wide/16 v0, 0x0

    invoke-static {v0, v1, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v14

    add-long/2addr v12, v14

    goto :goto_1

    .line 55
    :cond_3
    move-object/from16 v18, v0

    .line 59
    :goto_1
    nop

    .line 60
    move-wide v14, v9

    move-object/from16 v11, v17

    const/16 v0, 0x17

    goto :goto_3

    .line 61
    :cond_4
    move-object/from16 v18, v0

    const/4 v0, 0x2

    if-eq v6, v0, :cond_5

    const/16 v0, 0x17

    if-eq v6, v0, :cond_6

    const/16 v1, 0x18

    if-ne v6, v1, :cond_7

    goto :goto_2

    :cond_5
    const/16 v0, 0x17

    :cond_6
    :goto_2
    if-eqz v11, :cond_7

    .line 64
    move-object/from16 v1, v17

    invoke-virtual {v11, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 65
    nop

    .line 66
    invoke-static {v7, v8, v9, v10}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v9

    invoke-static {v4, v5, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v14

    sub-long/2addr v9, v14

    .line 65
    const-wide/16 v14, 0x0

    invoke-static {v14, v15, v9, v10}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v9

    add-long/2addr v12, v9

    .line 67
    nop

    .line 68
    const/4 v11, 0x0

    const-wide/16 v14, 0x0

    .line 70
    :cond_7
    :goto_3
    move v6, v0

    move-object/from16 v0, v18

    const/4 v1, 0x0

    goto :goto_0

    .line 71
    :cond_8
    if-eqz v11, :cond_9

    .line 72
    invoke-static {v4, v5, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v9

    sub-long v9, v7, v9

    const-wide/16 v14, 0x0

    invoke-static {v14, v15, v9, v10}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v9

    add-long/2addr v12, v9

    .line 75
    :cond_9
    const-wide/32 v9, 0x19bfcc0

    invoke-static {v9, v10, v12, v13}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v11

    .line 76
    sub-long v13, v9, v11

    .line 77
    long-to-double v1, v13

    const-wide/high16 v15, 0x4059000000000000L    # 100.0

    mul-double/2addr v1, v15

    const-wide v15, 0x4179bfcc00000000L    # 2.7E7

    div-double/2addr v1, v15

    invoke-static {v1, v2}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    .line 80
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 81
    invoke-virtual {v3}, Ljava/time/LocalDate;->toString()Ljava/lang/String;

    move-result-object v2

    .line 82
    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    const-string v6, "night-use-%s"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v15

    invoke-static {v3, v6, v15}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v6, "id"

    invoke-virtual {v1, v6, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 83
    const-string v3, "date"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 84
    const-string v2, "windowStartTime"

    invoke-virtual {v1, v2, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 85
    const-string v2, "windowEndTime"

    invoke-virtual {v1, v2, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 86
    const-string v2, "recoveryWindowMs"

    invoke-virtual {v1, v2, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 87
    const-string v2, "nightPhoneUseMs"

    invoke-virtual {v1, v2, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 88
    const-string v2, "phoneFreeMs"

    invoke-virtual {v1, v2, v13, v14}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 89
    const-string v2, "recoveryPercent"

    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 90
    const-string v0, "estimated"

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 91
    const-string v0, "source"

    const-string v2, "android_usage_events"

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 92
    const-string v0, "disclaimer"

    const-string v2, "Estimated from Android foreground app usage; not medical sleep tracking."

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 93
    return-object v1
.end method
