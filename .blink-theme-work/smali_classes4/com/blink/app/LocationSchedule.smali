.class public final Lcom/blink/app/LocationSchedule;
.super Ljava/lang/Object;
.source "LocationSchedule.java"


# static fields
.field private static final ACTION:Ljava/lang/String; = "com.blink.app.LOCATION_SCHEDULE"

.field private static final PREFS:Ljava/lang/String; = "blink_tracking"

.field private static final REQUEST_CODE:I = 0x125f

.field private static final TAG:Ljava/lang/String; = "BLINK"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    return-void
.end method

.method public static apply(Landroid/content/Context;)V
    .locals 6

    .line 50
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->scheduleNext(Landroid/content/Context;)V

    .line 51
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->shouldTrackNow(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 52
    nop

    .line 53
    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    const-string v1, "service_error"

    const/4 v2, 0x0

    const-string v3, "blink_tracking"

    if-eqz v0, :cond_0

    .line 55
    invoke-virtual {p0, v3, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 56
    const-string v0, "Grant precise location permission to start scheduled tracking."

    invoke-interface {p0, v1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 57
    return-void

    .line 59
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1d

    if-lt v0, v4, :cond_1

    invoke-static {}, Lcom/blink/app/LocationSchedule;->isWithinWindow()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 60
    invoke-virtual {p0, v3, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 61
    const-string v4, "location_schedule_enabled"

    const/4 v5, 0x1

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 62
    const-string v0, "android.permission.ACCESS_BACKGROUND_LOCATION"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    .line 64
    invoke-virtual {p0, v3, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 65
    const-string v0, "Allow background location so the 6:00\u20139:00 AM schedule can start while BLINK is closed."

    invoke-interface {p0, v1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 66
    return-void

    .line 68
    :cond_1
    new-instance v0, Landroid/content/Intent;

    const-class v4, Lcom/blink/app/LocationTrackingService;

    invoke-direct {v0, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 69
    const-string v4, "com.blink.app.START_TRACKING"

    invoke-virtual {v0, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 71
    :try_start_0
    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 77
    goto :goto_0

    .line 73
    :catch_0
    move-exception v0

    .line 74
    const-string v4, "BLINK"

    const-string v5, "Could not start scheduled location tracking."

    invoke-static {v4, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 75
    invoke-virtual {p0, v3, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not start scheduled location tracking: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 76
    invoke-virtual {v0}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0, v1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 78
    :goto_0
    goto :goto_1

    .line 79
    :cond_2
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/LocationTrackingService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 81
    :goto_1
    invoke-static {}, Lcom/blink/app/MainActivityReference;->get()Lcom/blink/app/MainActivity;

    move-result-object p0

    .line 82
    if-eqz p0, :cond_3

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 83
    :cond_3
    return-void
.end method

.method public static isEnabled(Landroid/content/Context;)Z
    .locals 2

    .line 26
    const-string v0, "blink_tracking"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 27
    const-string v0, "location_schedule_enabled"

    const/4 v1, 0x1

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    .line 26
    return p0
.end method

.method public static isWithinWindow()Z
    .locals 3

    .line 37
    invoke-static {}, Ljava/time/LocalTime;->now()Ljava/time/LocalTime;

    move-result-object v0

    .line 38
    const/4 v1, 0x6

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v1

    if-nez v1, :cond_0

    const/16 v1, 0x9

    invoke-static {v1, v2}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    :cond_0
    return v2
.end method

.method private static pendingIntent(Landroid/content/Context;)Landroid/app/PendingIntent;
    .locals 3

    .line 109
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/LocationScheduleReceiver;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.blink.app.LOCATION_SCHEDULE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 110
    nop

    .line 111
    nop

    .line 112
    const/16 v1, 0x125f

    const/high16 v2, 0xc000000

    invoke-static {p0, v1, v0, v2}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    return-object p0
.end method

.method public static scheduleNext(Landroid/content/Context;)V
    .locals 7

    .line 86
    const-class v0, Landroid/app/AlarmManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 87
    if-nez v0, :cond_0

    .line 88
    const-string p0, "BLINK"

    const-string v0, "Android alarm service is unavailable; scheduled location cannot be updated."

    invoke-static {p0, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 89
    return-void

    .line 91
    :cond_0
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->isEnabled(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 92
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->pendingIntent(Landroid/content/Context;)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 93
    return-void

    .line 95
    :cond_1
    invoke-static {}, Ljava/time/LocalDateTime;->now()Ljava/time/LocalDateTime;

    move-result-object v1

    .line 97
    invoke-virtual {v1}, Ljava/time/LocalDateTime;->toLocalTime()Ljava/time/LocalTime;

    move-result-object v2

    const/4 v3, 0x6

    const/4 v4, 0x0

    invoke-static {v3, v4}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 98
    invoke-virtual {v1}, Ljava/time/LocalDateTime;->toLocalDate()Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1, v3, v4}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v1

    goto :goto_0

    .line 99
    :cond_2
    invoke-virtual {v1}, Ljava/time/LocalDateTime;->toLocalTime()Ljava/time/LocalTime;

    move-result-object v2

    const/16 v5, 0x9

    invoke-static {v5, v4}, Ljava/time/LocalTime;->of(II)Ljava/time/LocalTime;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/time/LocalTime;->isBefore(Ljava/time/LocalTime;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 100
    invoke-virtual {v1}, Ljava/time/LocalDateTime;->toLocalDate()Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1, v5, v4}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v1

    goto :goto_0

    .line 102
    :cond_3
    invoke-static {}, Ljava/time/LocalDate;->now()Ljava/time/LocalDate;

    move-result-object v1

    const-wide/16 v5, 0x1

    invoke-virtual {v1, v5, v6}, Ljava/time/LocalDate;->plusDays(J)Ljava/time/LocalDate;

    move-result-object v1

    invoke-virtual {v1, v3, v4}, Ljava/time/LocalDate;->atTime(II)Ljava/time/LocalDateTime;

    move-result-object v1

    .line 104
    :goto_0
    nop

    .line 105
    invoke-static {}, Ljava/time/ZoneId;->systemDefault()Ljava/time/ZoneId;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/time/LocalDateTime;->atZone(Ljava/time/ZoneId;)Ljava/time/ZonedDateTime;

    move-result-object v1

    invoke-virtual {v1}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v1

    invoke-virtual {v1}, Ljava/time/Instant;->toEpochMilli()J

    move-result-wide v1

    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->pendingIntent(Landroid/content/Context;)Landroid/app/PendingIntent;

    move-result-object p0

    .line 104
    invoke-virtual {v0, v4, v1, v2, p0}, Landroid/app/AlarmManager;->setAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    .line 106
    return-void
.end method

.method public static setEnabled(Landroid/content/Context;Z)V
    .locals 2

    .line 31
    const-string v0, "blink_tracking"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 32
    const-string v1, "location_schedule_enabled"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 33
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    .line 34
    return-void
.end method

.method public static shouldTrackNow(Landroid/content/Context;)Z
    .locals 6

    .line 42
    const-string v0, "blink_tracking"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 43
    const-string v0, "location_enabled"

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 44
    const-string v2, "location_schedule_enabled"

    const/4 v3, 0x1

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {}, Lcom/blink/app/LocationSchedule;->isWithinWindow()Z

    move-result v2

    if-eqz v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    move v2, v1

    .line 45
    :goto_0
    const-string v4, "active_cardio"

    const-string v5, ""

    invoke-interface {p0, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    .line 46
    xor-int/2addr p0, v3

    if-nez v0, :cond_1

    if-nez v2, :cond_1

    if-eqz p0, :cond_2

    :cond_1
    move v1, v3

    :cond_2
    return v1
.end method
