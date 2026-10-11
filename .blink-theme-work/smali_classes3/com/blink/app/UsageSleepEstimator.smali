.class final Lcom/blink/app/UsageSleepEstimator;
.super Ljava/lang/Object;
.source "UsageSleepEstimator.java"


# instance fields
.field private final context:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    .line 31
    return-void
.end method

.method private calculateEstimate()Lorg/json/JSONObject;
    .locals 33
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/blink/app/NightUsageCalculator;->calculate(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0

    .line 141
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    const-string v2, "usagestats"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/usage/UsageStatsManager;

    .line 142
    .local v1, "manager":Landroid/app/usage/UsageStatsManager;
    const/4 v2, 0x0

    if-nez v1, :cond_0

    return-object v2

    .line 144
    :cond_0
    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v3

    .line 145
    .local v3, "today":Ljava/time/LocalDate;
    const-wide/16 v4, 0x1

    invoke-virtual {v3, v4, v5}, Ljava/time/LocalDate;->minusDays(J)Ljava/time/LocalDate;

    move-result-object v4

    .line 146
    .local v4, "yesterday":Ljava/time/LocalDate;
    invoke-static {}, Ljava/time/ZoneId;->systemDefault()Ljava/time/ZoneId;

    move-result-object v5

    .line 147
    .local v5, "zone":Ljava/time/ZoneId;
    const/16 v6, 0x14

    const/4 v7, 0x0

    invoke-virtual {v4, v6, v7}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v8

    invoke-virtual {v8}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v8

    invoke-virtual {v8}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v8

    .line 148
    .local v8, "from":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    .line 149
    .local v10, "to":J
    invoke-virtual {v1, v8, v9, v10, v11}, Landroid/app/usage/UsageStatsManager;->queryEvents(JJ)Landroid/app/usage/UsageEvents;

    move-result-object v12

    .line 150
    .local v12, "events":Landroid/app/usage/UsageEvents;
    if-nez v12, :cond_1

    return-object v2

    .line 152
    :cond_1
    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    .line 153
    .local v13, "activityTimes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Long;>;"
    new-instance v14, Landroid/app/usage/UsageEvents$Event;

    invoke-direct {v14}, Landroid/app/usage/UsageEvents$Event;-><init>()V

    .line 154
    .local v14, "event":Landroid/app/usage/UsageEvents$Event;
    :goto_0
    invoke-virtual {v12}, Landroid/app/usage/UsageEvents;->hasNextEvent()Z

    move-result v15

    if-eqz v15, :cond_3

    .line 155
    invoke-virtual {v12, v14}, Landroid/app/usage/UsageEvents;->getNextEvent(Landroid/app/usage/UsageEvents$Event;)Z

    .line 156
    invoke-virtual {v14}, Landroid/app/usage/UsageEvents$Event;->getEventType()I

    move-result v15

    invoke-static {v15}, Lcom/blink/app/UsageSleepEstimator;->isMeaningfulActivity(I)Z

    move-result v15

    if-nez v15, :cond_2

    goto :goto_0

    .line 157
    :cond_2
    invoke-virtual {v14}, Landroid/app/usage/UsageEvents$Event;->getTimeStamp()J

    move-result-wide v15

    invoke-static/range {v15 .. v16}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v15

    invoke-interface {v13, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 159
    :cond_3
    invoke-static {}, Ljava/util/Comparator;->naturalOrder()Ljava/util/Comparator;

    move-result-object v15

    invoke-interface {v13, v15}, Ljava/util/List;->sort(Ljava/util/Comparator;)V

    .line 160
    invoke-interface {v13}, Ljava/util/List;->isEmpty()Z

    move-result v15

    if-eqz v15, :cond_4

    return-object v2

    .line 162
    :cond_4
    const/4 v15, 0x6

    invoke-virtual {v3, v15, v7}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v15

    invoke-virtual {v15, v5}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v15

    invoke-virtual {v15}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v15

    invoke-virtual {v15}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v15

    .line 163
    .local v15, "quietWindow":J
    move-object/from16 v17, v2

    const/16 v2, 0xc

    invoke-virtual {v3, v2, v7}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v2

    invoke-virtual {v2}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v2

    invoke-virtual {v2}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v18

    .line 164
    .local v18, "morningEnd":J
    const-wide/16 v20, 0x0

    .line 165
    .local v20, "sleepStart":J
    const-wide/16 v22, 0x0

    .line 166
    .local v22, "wakeTime":J
    const/4 v2, 0x0

    .line 167
    .local v2, "lateNightUse":I
    invoke-interface {v13}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v24

    move-wide/from16 v25, v20

    .end local v20    # "sleepStart":J
    .local v25, "sleepStart":J
    :goto_1
    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    const-wide/16 v27, 0x0

    if-eqz v20, :cond_a

    invoke-interface/range {v24 .. v24}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v20

    check-cast v20, Ljava/lang/Long;

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Long;->longValue()J

    move-result-wide v20

    .line 168
    .local v20, "time":J
    invoke-static/range {v20 .. v21}, Ljava/time/Instant;->ofEpochMilli(J)Ljava/time/Instant;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/time/Instant;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v6

    invoke-virtual {v6}, Ljava/time/ZonedDateTime;->toLocalTime()Ljava/time/LocalTime;

    move-result-object v6

    .line 169
    .local v6, "localTime":Ljava/time/LocalTime;
    move-object/from16 v29, v1

    .line 170
    cmp-long v1, v20, v15

    if-gez v1, :cond_6

    .line 171
    move-wide/from16 v25, v20

    .line 172
    const/16 v1, 0x17

    invoke-static {v1, v7}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v1

    invoke-virtual {v6, v1}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v1

    if-nez v1, :cond_5

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_5
    const/4 v1, 0x6

    invoke-static {v1, v7}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v1

    invoke-virtual {v6, v1}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v1

    if-eqz v1, :cond_9

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 173
    :cond_6
    cmp-long v1, v20, v18

    if-gtz v1, :cond_7

    .line 174
    move-wide/from16 v0, v25

    .end local v25    # "sleepStart":J
    .local v0, "sleepStart":J
    cmp-long v25, v0, v27

    if-lez v25, :cond_8

    sub-long v25, v20, v0

    const-wide/32 v31, 0xa4cb80

    cmp-long v25, v25, v31

    if-ltz v25, :cond_8

    .line 175
    move-wide/from16 v22, v20

    .line 176
    move-wide/from16 v6, v22

    goto :goto_3

    .line 173
    .end local v0    # "sleepStart":J
    .restart local v25    # "sleepStart":J
    :cond_7
    move-wide/from16 v0, v25

    .line 179
    .end local v6    # "localTime":Ljava/time/LocalTime;
    .end local v20    # "time":J
    .end local v25    # "sleepStart":J
    .restart local v0    # "sleepStart":J
    :cond_8
    move-wide/from16 v25, v0

    .end local v0    # "sleepStart":J
    .restart local v25    # "sleepStart":J
    :cond_9
    :goto_2
    const/16 v6, 0x14

    move-object/from16 v0, p0

    move-object/from16 v1, v29

    goto :goto_1

    .line 167
    .end local v29
    .restart local v1    # "manager":Landroid/app/usage/UsageStatsManager;
    :cond_a
    move-object/from16 v29, v1

    move-wide/from16 v0, v25

    .end local v1    # "manager":Landroid/app/usage/UsageStatsManager;
    .end local v25    # "sleepStart":J
    .restart local v0    # "sleepStart":J
    .restart local v29
    move-wide/from16 v6, v22

    .line 180
    .end local v22    # "wakeTime":J
    .local v6, "wakeTime":J
    :goto_3
    cmp-long v20, v0, v27

    if-eqz v20, :cond_e

    cmp-long v20, v6, v27

    if-nez v20, :cond_b

    move-object/from16 v20, v3

    move-object/from16 v21, v4

    move-wide/from16 v25, v8

    goto/16 :goto_5

    .line 182
    :cond_b
    move-object/from16 v20, v3

    move-object/from16 v21, v4

    .end local v3    # "today":Ljava/time/LocalDate;
    .end local v4    # "yesterday":Ljava/time/LocalDate;
    .local v20, "today":Ljava/time/LocalDate;
    .local v21, "yesterday":Ljava/time/LocalDate;
    sub-long v3, v6, v0

    long-to-double v3, v3

    const-wide v22, 0x414b774000000000L    # 3600000.0

    div-double v3, v3, v22

    .line 183
    .local v3, "hours":D
    const-wide/high16 v22, 0x4008000000000000L    # 3.0

    cmpg-double v22, v3, v22

    if-ltz v22, :cond_d

    const-wide/high16 v22, 0x402c000000000000L    # 14.0

    cmpl-double v22, v3, v22

    if-lez v22, :cond_c

    move-wide/from16 v23, v3

    move-wide/from16 v25, v8

    goto/16 :goto_4

    .line 184
    :cond_c
    new-instance v17, Lorg/json/JSONObject;

    invoke-direct/range {v17 .. v17}, Lorg/json/JSONObject;-><init>()V

    move-object/from16 v22, v17

    .line 185
    .local v22, "estimate":Lorg/json/JSONObject;
    move-wide/from16 v23, v3

    .end local v3    # "hours":D
    .local v23, "hours":D
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "sleep-"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 186
    invoke-static {v6, v7}, Ljava/time/Instant;->ofEpochMilli(J)Ljava/time/Instant;

    move-result-object v4

    invoke-static {v4, v5}, Ljava/time/LocalDateTime;->ofInstant(Ljava/time/Instant;Ljava/time/ZoneId;)Ljava/time/LocalDateTime;

    move-result-object v4

    invoke-virtual {v4}, Ljava/time/LocalDateTime;->toLocalDate()Ljava/time/LocalDate;

    move-result-object v4

    invoke-virtual {v4}, Ljava/time/LocalDate;->toString()Ljava/lang/String;

    move-result-object v4

    move-wide/from16 v25, v8

    .end local v8    # "from":J
    .local v25, "from":J
    sget-object v8, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 187
    invoke-virtual {v4, v8}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    .line 185
    invoke-static {v4}, Ljava/util/UUID;->nameUUIDFromBytes([B)Ljava/util/UUID;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "id"

    move-object/from16 v8, v22

    .end local v22    # "estimate":Lorg/json/JSONObject;
    .local v8, "estimate":Lorg/json/JSONObject;
    invoke-virtual {v8, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 188
    invoke-static {v6, v7}, Ljava/time/Instant;->ofEpochMilli(J)Ljava/time/Instant;

    move-result-object v3

    invoke-static {v3, v5}, Ljava/time/LocalDateTime;->ofInstant(Ljava/time/Instant;Ljava/time/ZoneId;)Ljava/time/LocalDateTime;

    move-result-object v3

    invoke-virtual {v3}, Ljava/time/LocalDateTime;->toLocalDate()Ljava/time/LocalDate;

    move-result-object v3

    invoke-virtual {v3}, Ljava/time/LocalDate;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "date"

    invoke-virtual {v8, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 189
    const-string v3, "sleepStartTime"

    invoke-virtual {v8, v3, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 190
    const-string v3, "wakeTime"

    invoke-virtual {v8, v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 191
    const-wide/high16 v3, 0x4059000000000000L    # 100.0

    mul-double v27, v23, v3

    move-wide/from16 v30, v3

    invoke-static/range {v27 .. v28}, Ljava/lang/Math;->round(D)J

    move-result-wide v3

    long-to-double v3, v3

    div-double v3, v3, v30

    const-string v9, "hours"

    invoke-virtual {v8, v9, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 192
    const-string v3, "lateNightUseCount"

    invoke-virtual {v8, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 193
    const-string v3, "expectedSleepWindowStart"

    const-string v4, "23:00"

    invoke-virtual {v8, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 194
    const-string v3, "estimated"

    const/4 v4, 0x1

    invoke-virtual {v8, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 195
    const-string v3, "source"

    const-string v4, "android_usage_stats"

    invoke-virtual {v8, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 196
    return-object v8

    .line 183
    .end local v23    # "hours":D
    .end local v25    # "from":J
    .restart local v3    # "hours":D
    .local v8, "from":J
    :cond_d
    move-wide/from16 v23, v3

    move-wide/from16 v25, v8

    .end local v3    # "hours":D
    .end local v8    # "from":J
    .restart local v23    # "hours":D
    .restart local v25    # "from":J
    :goto_4
    return-object v17

    .line 180
    .end local v20    # "today":Ljava/time/LocalDate;
    .end local v21    # "yesterday":Ljava/time/LocalDate;
    .end local v23    # "hours":D
    .end local v25    # "from":J
    .local v3, "today":Ljava/time/LocalDate;
    .restart local v4    # "yesterday":Ljava/time/LocalDate;
    .restart local v8    # "from":J
    :cond_e
    move-object/from16 v20, v3

    move-object/from16 v21, v4

    move-wide/from16 v25, v8

    .end local v3    # "today":Ljava/time/LocalDate;
    .end local v4    # "yesterday":Ljava/time/LocalDate;
    .end local v8    # "from":J
    .restart local v20    # "today":Ljava/time/LocalDate;
    .restart local v21    # "yesterday":Ljava/time/LocalDate;
    .restart local v25    # "from":J
    :goto_5
    return-object v17
.end method

.method static hasUsageAccess(Landroid/content/Context;)Z
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .line 34
    const-string v0, "appops"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AppOpsManager;

    .line 35
    .local v0, "appOps":Landroid/app/AppOpsManager;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 38
    :cond_0
    :try_start_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v3, 0x1d

    const-string v4, "android:get_usage_stats"

    if-lt v2, v3, :cond_1

    .line 39
    nop

    .line 40
    :try_start_1
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v2

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 39
    invoke-virtual {v0, v4, v2, v3}, Landroid/app/AppOpsManager;->unsafeCheckOpNoThrow(Ljava/lang/String;ILjava/lang/String;)I

    move-result v2

    .local v2, "mode":I
    goto :goto_0

    .line 42
    .end local v2    # "mode":I
    :cond_1
    nop

    .line 43
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v2

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 42
    invoke-virtual {v0, v4, v2, v3}, Landroid/app/AppOpsManager;->checkOpNoThrow(Ljava/lang/String;ILjava/lang/String;)I

    move-result v2
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_0

    .line 45
    .restart local v2    # "mode":I
    :goto_0
    if-nez v2, :cond_2

    const/4 v1, 0x1

    :cond_2
    return v1

    .line 46
    .end local v2    # "mode":I
    :catch_0
    move-exception v2

    .line 47
    .local v2, "error":Ljava/lang/SecurityException;
    return v1
.end method

.method private static isMeaningfulActivity(I)Z
    .locals 3
    .param p0, "type"    # I

    .line 200
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    return v0

    .line 201
    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_1

    if-ne p0, v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method static synthetic lambda$appUsageToday$0(Lorg/json/JSONObject;Lorg/json/JSONObject;)I
    .locals 5
    .param p0, "first"    # Lorg/json/JSONObject;
    .param p1, "second"    # Lorg/json/JSONObject;

    .line 123
    const-string v0, "milliseconds"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v3

    invoke-static {v1, v2, v3, v4}, Ljava/lang/Long;->compare(JJ)I

    move-result v0

    return v0
.end method


# virtual methods
.method appUsageToday()Ljava/lang/String;
    .locals 23

    .line 88
    move-object/from16 v1, p0

    const-string v2, "granted"

    const-string v3, "BLINK"

    const-string v4, "apps"

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    move-object v5, v0

    .line 90
    .local v5, "result":Lorg/json/JSONObject;
    const/4 v6, 0x0

    :try_start_0
    iget-object v0, v1, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/blink/app/UsageSleepEstimator;->hasUsageAccess(Landroid/content/Context;)Z

    move-result v0

    move v7, v0

    .line 91
    .local v7, "granted":Z
    invoke-virtual {v5, v2, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 92
    if-nez v7, :cond_0

    .line 93
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {v5, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 94
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 96
    :cond_0
    iget-object v0, v1, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    const-string v8, "usagestats"

    .line 97
    invoke-virtual {v0, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/usage/UsageStatsManager;

    move-object v8, v0

    .line 98
    .local v8, "manager":Landroid/app/usage/UsageStatsManager;
    if-eqz v8, :cond_4

    .line 99
    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v0

    move-object v9, v0

    .line 100
    .local v9, "today":Ljava/time/LocalDate;
    invoke-static {}, Ljava/time/ZoneId;->systemDefault()Ljava/time/ZoneId;

    move-result-object v0

    invoke-virtual {v9, v0}, Ljava/time/LocalDate;->atStartOfDay(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v0

    invoke-virtual {v0}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v10

    .line 101
    .local v10, "start":J
    nop

    .line 102
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    invoke-virtual {v8, v10, v11, v12, v13}, Landroid/app/usage/UsageStatsManager;->queryAndAggregateUsageStats(JJ)Ljava/util/Map;

    move-result-object v0

    move-object v12, v0

    .line 103
    .local v12, "usage":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Landroid/app/usage/UsageStats;>;"
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    move-object v13, v0

    .line 104
    .local v13, "apps":Lorg/json/JSONArray;
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v14, v0

    .line 105
    .local v14, "rows":Ljava/util/List;, "Ljava/util/List<Lorg/json/JSONObject;>;"
    iget-object v0, v1, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    move-object v15, v0

    .line 106
    .local v15, "packages":Landroid/content/pm/PackageManager;
    invoke-interface {v12}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v16

    :goto_0
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    move-object/from16 v17, v0

    .line 107
    .local v17, "item":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Landroid/app/usage/UsageStats;>;"
    invoke-interface/range {v17 .. v17}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/usage/UsageStats;

    invoke-virtual {v0}, Landroid/app/usage/UsageStats;->getTotalTimeInForeground()J

    move-result-wide v18

    move-wide/from16 v20, v18

    .line 108
    .local v20, "milliseconds":J
    const-wide/16 v18, 0x0

    cmp-long v0, v20, v18

    if-gtz v0, :cond_1

    goto :goto_0

    .line 109
    :cond_1
    invoke-interface/range {v17 .. v17}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-object/from16 v18, v0

    .line 111
    .local v18, "label":Ljava/lang/String;
    :try_start_1
    invoke-interface/range {v17 .. v17}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v15, v0, v6}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 112
    .local v0, "info":Landroid/content/pm/ApplicationInfo;
    invoke-virtual {v15, v0}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;

    move-result-object v19

    invoke-static/range {v19 .. v19}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v19
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-object/from16 v18, v19

    .line 115
    .end local v0    # "info":Landroid/content/pm/ApplicationInfo;
    move-object/from16 v0, v18

    goto :goto_1

    .line 113
    :catch_0
    move-exception v0

    .line 114
    .local v0, "ignored":Landroid/content/pm/PackageManager$NameNotFoundException;
    :try_start_2
    const-string v6, "UsageStats returned an uninstalled package."

    invoke-static {v3, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, v18

    .line 116
    .end local v18    # "label":Ljava/lang/String;
    .local v0, "label":Ljava/lang/String;
    :goto_1
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 117
    .local v6, "row":Lorg/json/JSONObject;
    const-string v1, "packageName"

    move/from16 v18, v7

    .end local v7    # "granted":Z
    .local v18, "granted":Z
    invoke-interface/range {v17 .. v17}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, v1, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 118
    const-string v1, "name"

    invoke-virtual {v6, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 119
    const-string v1, "milliseconds"

    move-object/from16 v22, v8

    move-wide/from16 v7, v20

    .end local v8    # "manager":Landroid/app/usage/UsageStatsManager;
    .end local v20    # "milliseconds":J
    .local v7, "milliseconds":J
    .local v22, "manager":Landroid/app/usage/UsageStatsManager;
    invoke-virtual {v6, v1, v7, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 120
    invoke-interface {v14, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 121
    const/4 v6, 0x0

    move-object/from16 v1, p0

    move/from16 v7, v18

    move-object/from16 v8, v22

    .end local v0    # "label":Ljava/lang/String;
    .end local v6    # "row":Lorg/json/JSONObject;
    .end local v7    # "milliseconds":J
    .end local v17    # "item":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Landroid/app/usage/UsageStats;>;"
    goto :goto_0

    .line 122
    .end local v18    # "granted":Z
    .end local v22    # "manager":Landroid/app/usage/UsageStatsManager;
    .local v7, "granted":Z
    .restart local v8    # "manager":Landroid/app/usage/UsageStatsManager;
    :cond_2
    move/from16 v18, v7

    move-object/from16 v22, v8

    .end local v7    # "granted":Z
    .end local v8    # "manager":Landroid/app/usage/UsageStatsManager;
    .restart local v18    # "granted":Z
    .restart local v22    # "manager":Landroid/app/usage/UsageStatsManager;
    new-instance v0, Lcom/blink/app/UsageSleepEstimator$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/blink/app/UsageSleepEstimator$$ExternalSyntheticLambda0;-><init>()V

    invoke-interface {v14, v0}, Ljava/util/List;->sort(Ljava/util/Comparator;)V

    .line 124
    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/json/JSONObject;

    .local v1, "row":Lorg/json/JSONObject;
    invoke-virtual {v13, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_2

    .line 125
    .end local v1    # "row":Lorg/json/JSONObject;
    :cond_3
    invoke-virtual {v5, v4, v13}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 126
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 98
    .end local v9    # "today":Ljava/time/LocalDate;
    .end local v10    # "start":J
    .end local v12    # "usage":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Landroid/app/usage/UsageStats;>;"
    .end local v13    # "apps":Lorg/json/JSONArray;
    .end local v14    # "rows":Ljava/util/List;, "Ljava/util/List<Lorg/json/JSONObject;>;"
    .end local v15    # "packages":Landroid/content/pm/PackageManager;
    .end local v18    # "granted":Z
    .end local v22    # "manager":Landroid/app/usage/UsageStatsManager;
    .restart local v7    # "granted":Z
    .restart local v8    # "manager":Landroid/app/usage/UsageStatsManager;
    :cond_4
    move/from16 v18, v7

    move-object/from16 v22, v8

    .end local v7    # "granted":Z
    .end local v8    # "manager":Landroid/app/usage/UsageStatsManager;
    .restart local v18    # "granted":Z
    .restart local v22    # "manager":Landroid/app/usage/UsageStatsManager;
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Android UsageStats is unavailable."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v5    # "result":Lorg/json/JSONObject;
    throw v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 127
    .end local v18    # "granted":Z
    .end local v22    # "manager":Landroid/app/usage/UsageStatsManager;
    .restart local v5    # "result":Lorg/json/JSONObject;
    :catch_1
    move-exception v0

    move-object v1, v0

    .line 128
    .local v1, "error":Ljava/lang/Exception;
    const-string v0, "Could not read Android app usage."

    invoke-static {v3, v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 130
    const/4 v3, 0x0

    :try_start_3
    invoke-virtual {v5, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 131
    const-string v0, "error"

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_5

    const-string v2, "UsageStats is unavailable."

    goto :goto_3

    :cond_5
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    :goto_3
    invoke-virtual {v5, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 132
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {v5, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_2

    .line 135
    nop

    .line 136
    invoke-virtual {v5}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 133
    :catch_2
    move-exception v0

    .line 134
    .local v0, "ignored":Lorg/json/JSONException;
    const-string v2, "{\"granted\":false,\"error\":\"UsageStats is unavailable.\",\"apps\":[]}"

    return-object v2
.end method

.method refreshEstimate()Ljava/lang/String;
    .locals 6

    .line 52
    const-string v0, "status"

    new-instance v1, Lcom/blink/app/TrackingStore;

    iget-object v2, p0, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    invoke-direct {v1, v2}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 53
    .local v1, "store":Lcom/blink/app/TrackingStore;
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 55
    .local v2, "result":Lorg/json/JSONObject;
    :try_start_0
    const-string v3, "enabled"

    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->isSleepEstimationEnabled()Z

    move-result v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 56
    const-string v3, "granted"

    iget-object v4, p0, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    invoke-static {v4}, Lcom/blink/app/UsageSleepEstimator;->hasUsageAccess(Landroid/content/Context;)Z

    move-result v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 57
    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->isSleepEstimationEnabled()Z

    move-result v3

    if-nez v3, :cond_0

    .line 58
    const-string v3, "disabled"

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 59
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 61
    :cond_0
    iget-object v3, p0, Lcom/blink/app/UsageSleepEstimator;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/blink/app/UsageSleepEstimator;->hasUsageAccess(Landroid/content/Context;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 62
    const-string v3, "permission_required"

    invoke-virtual {v2, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 63
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 65
    :cond_1
    invoke-direct {p0}, Lcom/blink/app/UsageSleepEstimator;->calculateEstimate()Lorg/json/JSONObject;

    move-result-object v3

    .line 66
    .local v3, "estimate":Lorg/json/JSONObject;
    if-nez v3, :cond_2

    .line 67
    const-string v4, "insufficient_data"

    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 68
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 70
    :cond_2
    invoke-virtual {v1, v3}, Lcom/blink/app/TrackingStore;->saveSleepEstimate(Lorg/json/JSONObject;)V

    .line 71
    const-string v4, "estimated"

    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 72
    const-string v4, "estimate"

    invoke-virtual {v2, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 73
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 74
    .end local v3    # "estimate":Lorg/json/JSONObject;
    :catch_0
    move-exception v3

    .line 75
    .local v3, "error":Ljava/lang/Exception;
    const-string v4, "BLINK"

    const-string v5, "Could not estimate sleep from Android UsageStats."

    invoke-static {v4, v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 77
    :try_start_1
    const-string v4, "unavailable"

    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 78
    const-string v0, "error"

    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_3

    .line 79
    const-string v4, "Usage data could not be read."

    goto :goto_0

    :cond_3
    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    .line 78
    :goto_0
    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 82
    nop

    .line 83
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 80
    :catch_1
    move-exception v0

    .line 81
    .local v0, "ignored":Lorg/json/JSONException;
    const-string v4, "{\"status\":\"unavailable\"}"

    return-object v4
.end method
