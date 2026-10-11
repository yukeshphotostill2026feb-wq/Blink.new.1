.class public final Lcom/blink/app/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# static fields
.field private static final CLASS_REMINDER_PERMISSION_ASKED:Ljava/lang/String; = "class_reminder_permission_asked"

.field private static final NOTIFICATION_PERMISSION_PREFS:Ljava/lang/String; = "blink_notification_permissions"

.field private static final REQUEST_ACTIVITY:I = 0xb

.field private static final REQUEST_BACKGROUND:I = 0xc

.field private static final REQUEST_GOOGLE_SIGN_IN:I = 0x10

.field private static final REQUEST_LOCATION:I = 0xa

.field private static final REQUEST_NOTIFICATIONS:I = 0xd

.field private static final REQUEST_SCHEDULE_FILE:I = 0xe

.field private static final REQUEST_SCHEDULE_SAVE:I = 0xf

.field private static final SCRAMBLE_CHARS:[C

.field private static final SPLASH_DURATION_MS:J = 0x2bcL

.field private static final SPLASH_NAME:Ljava/lang/String; = "BLINK"


# instance fields
.field private activityPermissionAskedThisFlow:Z

.field private assetLoader:Landroidx/webkit/WebViewAssetLoader;

.field private geofencingClient:Lcom/google/android/gms/location/GeofencingClient;

.field private googleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

.field private pendingFileChooser:Landroid/webkit/ValueCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/webkit/ValueCallback<",
            "[",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation
.end field

.field private pendingGoogleSignInRequest:Ljava/lang/String;

.field private pendingScheduleBackup:Ljava/lang/String;

.field private pendingScheduleOcr:Z

.field private permissionFlowActive:Z

.field private final scheduleOcrExecutor:Ljava/util/concurrent/ExecutorService;

.field private splashOverlay:Landroid/widget/FrameLayout;

.field private webView:Landroid/webkit/WebView;


# direct methods
.method public static synthetic $r8$lambda$22v7LyLXquu6C4T_pbIh8aYbd90(Lcom/blink/app/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/blink/app/MainActivity;->lambda$onResume$13()V

    return-void
.end method

.method public static synthetic $r8$lambda$2T3IsV5AuvOq3GhI4eU82t6gFHE(Lcom/blink/app/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$explainBackgroundLocation$14(Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$32OAZbrcUl291Wu-tC_bPsxnE9c(Lcom/blink/app/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->lambda$deliverScheduleOcrError$10(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$5nNtJ4qbbvB4juGnHeyQ5pgNjIs(Lcom/blink/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$showNotification$16(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$HTOmJWO89WODdIyEPf9Zw0IWK2E(Lcom/blink/app/MainActivity;Landroid/net/Uri;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->lambda$extractPdfText$7(Landroid/net/Uri;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Jm34cZyd_avhtwOclrr-qQUrzEQ(Lcom/blink/app/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->lambda$deliverScheduleOcr$9(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Khn3zb2JMh3aE77IuhhOvuW8A9w(Lcom/blink/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$saveScheduleBackup$8(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Lo4RFBchaHwzn0-ed25ruQsj7-M(Lcom/blink/app/MainActivity;Lcom/google/mlkit/vision/text/TextRecognizer;Ljava/lang/Exception;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$extractScheduleText$6(Lcom/google/mlkit/vision/text/TextRecognizer;Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$OcAAF5DPCCAto4avMx9IaniOdI4(Lcom/blink/app/MainActivity;Lcom/google/mlkit/vision/text/TextRecognizer;Lcom/google/mlkit/vision/text/Text;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$extractScheduleText$5(Lcom/google/mlkit/vision/text/TextRecognizer;Lcom/google/mlkit/vision/text/Text;)V

    return-void
.end method

.method public static synthetic $r8$lambda$UJnaueV1OQi5zRu6dFMSfwNP3xU(Lcom/blink/app/MainActivity;ZLjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$notifyScheduleBackup$11(ZLjava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Zy7FZGaUI2HQgZTQd0yUCuVsxUg(Lcom/blink/app/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->lambda$selectScheduleFile$1(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$a8VZWv4Deavy3JWWY-5xmTQvG-M(Lcom/blink/app/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/blink/app/MainActivity;->lambda$publishTrackingUpdate$17()V

    return-void
.end method

.method public static synthetic $r8$lambda$cNFEOdq9mIQ4tTGZ1bBxkUsdGn8(Lcom/blink/app/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->lambda$requestGoogleSignIn$2(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$cdg4FZ1G4QpndHGSeThfiW5ec-0(Lcom/blink/app/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->lambda$deliverGoogleSignInResult$4(Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$wnkbS3Q5XhL4QyJiDn9YuxIavSo(Lcom/blink/app/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/blink/app/MainActivity;->lambda$explainBackgroundLocation$15(Landroid/content/DialogInterface;I)V

    return-void
.end method

.method static bridge synthetic -$$Nest$fgetassetLoader(Lcom/blink/app/MainActivity;)Landroidx/webkit/WebViewAssetLoader;
    .locals 0

    iget-object p0, p0, Lcom/blink/app/MainActivity;->assetLoader:Landroidx/webkit/WebViewAssetLoader;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetpendingFileChooser(Lcom/blink/app/MainActivity;)Landroid/webkit/ValueCallback;
    .locals 0

    iget-object p0, p0, Lcom/blink/app/MainActivity;->pendingFileChooser:Landroid/webkit/ValueCallback;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetpendingScheduleOcr(Lcom/blink/app/MainActivity;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/blink/app/MainActivity;->pendingScheduleOcr:Z

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetsplashOverlay(Lcom/blink/app/MainActivity;)Landroid/widget/FrameLayout;
    .locals 0

    iget-object p0, p0, Lcom/blink/app/MainActivity;->splashOverlay:Landroid/widget/FrameLayout;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetwebView(Lcom/blink/app/MainActivity;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputpendingFileChooser(Lcom/blink/app/MainActivity;Landroid/webkit/ValueCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/blink/app/MainActivity;->pendingFileChooser:Landroid/webkit/ValueCallback;

    return-void
.end method

.method static bridge synthetic -$$Nest$fputpendingScheduleOcr(Lcom/blink/app/MainActivity;Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/blink/app/MainActivity;->pendingScheduleOcr:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$fputsplashOverlay(Lcom/blink/app/MainActivity;Landroid/widget/FrameLayout;)V
    .locals 0

    iput-object p1, p0, Lcom/blink/app/MainActivity;->splashOverlay:Landroid/widget/FrameLayout;

    return-void
.end method

.method static bridge synthetic -$$Nest$macceptedPickerType(Lcom/blink/app/MainActivity;Landroid/webkit/WebChromeClient$FileChooserParams;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->acceptedPickerType(Landroid/webkit/WebChromeClient$FileChooserParams;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$misAllowedAppNavigation(Lcom/blink/app/MainActivity;Landroid/net/Uri;)Z
    .locals 0

    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->isAllowedAppNavigation(Landroid/net/Uri;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 61
    const-string v0, "0123456789!@#$%&*+=?"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    sput-object v0, Lcom/blink/app/MainActivity;->SCRAMBLE_CHARS:[C

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 58
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 82
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/MainActivity;->scheduleOcrExecutor:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method private acceptedPickerType(Landroid/webkit/WebChromeClient$FileChooserParams;)Ljava/lang/String;
    .locals 5
    .param p1, "params"    # Landroid/webkit/WebChromeClient$FileChooserParams;

    .line 225
    invoke-virtual {p1}, Landroid/webkit/WebChromeClient$FileChooserParams;->getAcceptTypes()[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 226
    .local v3, "type":Ljava/lang/String;
    if-eqz v3, :cond_0

    invoke-static {v3}, Lcom/blink/app/MainActivity$$ExternalSyntheticBackport0;->m(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "/"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    return-object v3

    .line 225
    .end local v3    # "type":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 228
    :cond_1
    const-string v0, "*/*"

    return-object v0
.end method

.method private continuePermissionFlow()V
    .locals 5

    .line 601
    iget-boolean v0, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    if-nez v0, :cond_0

    return-void

    .line 602
    :cond_0
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 603
    .local v0, "store":Lcom/blink/app/TrackingStore;
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v1, :cond_1

    .line 604
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const-string v4, "android.permission.ACCESS_COARSE_LOCATION"

    aput-object v4, v1, v3

    const-string v3, "android.permission.ACCESS_FINE_LOCATION"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    invoke-virtual {p0, v1, v2}, Lcom/blink/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 606
    return-void

    .line 608
    :cond_1
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isActivityTrackingEnabled()Z

    move-result v1

    if-eqz v1, :cond_2

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1d

    if-lt v1, v4, :cond_2

    iget-boolean v1, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    if-nez v1, :cond_2

    .line 611
    const-string v1, "android.permission.ACTIVITY_RECOGNITION"

    invoke-virtual {p0, v1}, Lcom/blink/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v4

    if-eqz v4, :cond_2

    .line 612
    new-array v2, v2, [Ljava/lang/String;

    aput-object v1, v2, v3

    const/16 v1, 0xb

    invoke-virtual {p0, v2, v1}, Lcom/blink/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 613
    return-void

    .line 615
    :cond_2
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->hasGymLocation()Z

    move-result v1

    if-nez v1, :cond_4

    .line 616
    iput-boolean v3, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 617
    const-string v1, "Choose the gym location on the map before enabling background gym detection."

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 618
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isLocationTrackingEnabled()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-direct {p0}, Lcom/blink/app/MainActivity;->startTrackingService()V

    .line 619
    :cond_3
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 620
    return-void

    .line 622
    :cond_4
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v1

    if-nez v1, :cond_5

    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->isEnabled(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_6

    :cond_5
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasBackgroundLocationPermission()Z

    move-result v1

    if-nez v1, :cond_6

    .line 623
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->explainBackgroundLocation()V

    .line 624
    return-void

    .line 626
    :cond_6
    iput-boolean v3, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 627
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->consumeCardioStartRequested()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->startCardio()V

    .line 628
    :cond_7
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    .line 629
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-direct {p0}, Lcom/blink/app/MainActivity;->registerGymGeofence()V

    .line 630
    :cond_8
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->requestNotificationPermissionIfNeeded()V

    .line 631
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 632
    return-void
.end method

.method private createNotificationChannel()V
    .locals 5

    .line 898
    nop

    .line 899
    new-instance v0, Landroid/app/NotificationChannel;

    const-string v1, "BLINK tracking"

    const/4 v2, 0x2

    const-string v3, "blink_tracking"

    invoke-direct {v0, v3, v1, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 901
    .local v0, "channel":Landroid/app/NotificationChannel;
    const-string v1, "Visible notification while BLINK uses location tracking."

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 902
    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "BLINK reminders"

    const/4 v3, 0x3

    const-string v4, "blink_reminders"

    invoke-direct {v1, v4, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 904
    .local v1, "reminders":Landroid/app/NotificationChannel;
    const-string v2, "Notifications from your existing BLINK reminders."

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 905
    const-class v2, Landroid/app/NotificationManager;

    invoke-virtual {p0, v2}, Lcom/blink/app/MainActivity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/NotificationManager;

    .line 906
    .local v2, "manager":Landroid/app/NotificationManager;
    invoke-virtual {v2, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 907
    invoke-virtual {v2, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 908
    return-void
.end method

.method private createSplashOverlay()Landroid/widget/FrameLayout;
    .locals 11

    .line 471
    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 472
    .local v0, "overlay":Landroid/widget/FrameLayout;
    const/4 v1, 0x6

    const/4 v2, 0x7

    const/4 v3, 0x5

    invoke-static {v3, v1, v2}, Landroid/graphics/Color;->rgb(III)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    .line 473
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 474
    .local v1, "wordmark":Landroid/widget/LinearLayout;
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 475
    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 476
    const/16 v3, 0xf2

    const/16 v4, 0xec

    const/16 v5, 0xf4

    invoke-static {v5, v3, v4}, Landroid/graphics/Color;->rgb(III)I

    move-result v3

    .line 477
    .local v3, "textColor":I
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    iget v4, v4, Landroid/util/DisplayMetrics;->density:F

    const/high16 v5, 0x42380000    # 46.0f

    mul-float/2addr v4, v5

    const/high16 v5, 0x3f000000    # 0.5f

    add-float/2addr v4, v5

    float-to-int v4, v4

    .line 478
    .local v4, "characterWidth":I
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_0
    const-string v6, "BLINK"

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    const/4 v7, 0x1

    const/4 v8, -0x2

    if-ge v5, v6, :cond_0

    .line 479
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 480
    .local v6, "character":Landroid/widget/TextView;
    invoke-virtual {v6, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 481
    invoke-virtual {v6, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 482
    const/high16 v9, 0x42180000    # 38.0f

    invoke-virtual {v6, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 483
    sget-object v9, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v6, v9, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 484
    sget-object v7, Lcom/blink/app/MainActivity;->SCRAMBLE_CHARS:[C

    mul-int/lit8 v9, v5, 0x7

    add-int/lit8 v9, v9, 0x3

    sget-object v10, Lcom/blink/app/MainActivity;->SCRAMBLE_CHARS:[C

    array-length v10, v10

    rem-int/2addr v9, v10

    aget-char v7, v7, v9

    invoke-static {v7}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 485
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v4, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 487
    .local v7, "params":Landroid/widget/LinearLayout$LayoutParams;
    invoke-virtual {v1, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 478
    .end local v6    # "character":Landroid/widget/TextView;
    .end local v7    # "params":Landroid/widget/LinearLayout$LayoutParams;
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 489
    .end local v5    # "index":I
    :cond_0
    new-instance v5, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v5, v8, v8, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v0, v1, v5}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 492
    invoke-virtual {v0, v7}, Landroid/widget/FrameLayout;->setImportantForAccessibility(I)V

    .line 493
    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setImportantForAccessibility(I)V

    .line 494
    return-object v0
.end method

.method private deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "requestId"    # Ljava/lang/String;
    .param p2, "idToken"    # Ljava/lang/String;
    .param p3, "error"    # Ljava/lang/String;

    .line 350
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 351
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "(()=>{const frame=document.querySelector(\'iframe\');const app=frame?.contentWindow||window;app.blinkCloudSync?.onNativeGoogleSignInResult("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 354
    invoke-static {p1}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 355
    const-string v2, "null"

    if-nez p2, :cond_1

    move-object v3, v2

    goto :goto_0

    :cond_1
    invoke-static {p2}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_0
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 356
    if-nez p3, :cond_2

    goto :goto_1

    :cond_2
    invoke-static {p3}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :goto_1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")})()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 358
    .local v0, "callback":Ljava/lang/String;
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda14;

    invoke-direct {v2, p0, v0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda14;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 359
    return-void
.end method

.method private deliverScheduleOcr(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    .line 447
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 448
    :cond_0
    if-nez p1, :cond_1

    const-string v0, ""

    goto :goto_0

    :cond_1
    move-object v0, p1

    :goto_0
    invoke-static {v0}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 449
    .local v0, "safeText":Ljava/lang/String;
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda16;

    invoke-direct {v2, p0, v0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda16;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 452
    return-void
.end method

.method private deliverScheduleOcrError(Ljava/lang/String;)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;

    .line 455
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 456
    :cond_0
    invoke-static {p1}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 457
    .local v0, "safeMessage":Ljava/lang/String;
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda7;

    invoke-direct {v2, p0, v0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda7;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 460
    return-void
.end method

.method private explainBackgroundLocation()V
    .locals 3

    .line 635
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 636
    const-string v1, "Allow background location"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 637
    const-string v1, "The daily 6:00\u20138:00 AM location schedule and gym detection need \"Allow all the time\" so BLINK can work when the app is closed. GPS is otherwise off unless you manually start tracking."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda18;

    invoke-direct {v1, p0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda18;-><init>(Lcom/blink/app/MainActivity;)V

    .line 638
    const-string v2, "Not now"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/blink/app/MainActivity;)V

    .line 643
    const-string v2, "Continue"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 654
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 655
    return-void
.end method

.method private extractPdfText(Landroid/net/Uri;)V
    .locals 2
    .param p1, "uri"    # Landroid/net/Uri;

    .line 388
    iget-object v0, p0, Lcom/blink/app/MainActivity;->scheduleOcrExecutor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda15;

    invoke-direct {v1, p0, p1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda15;-><init>(Lcom/blink/app/MainActivity;Landroid/net/Uri;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 426
    return-void
.end method

.method private extractScheduleText(Landroid/net/Uri;)V
    .locals 5
    .param p1, "uri"    # Landroid/net/Uri;

    .line 362
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v0

    .line 363
    .local v0, "mime":Ljava/lang/String;
    const-string v1, "application/pdf"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    const-string v2, ".pdf"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 367
    :cond_0
    sget-object v1, Lcom/google/mlkit/vision/text/latin/TextRecognizerOptions;->DEFAULT_OPTIONS:Lcom/google/mlkit/vision/text/latin/TextRecognizerOptions;

    invoke-static {v1}, Lcom/google/mlkit/vision/text/TextRecognition;->getClient(Lcom/google/mlkit/vision/text/TextRecognizerOptionsInterface;)Lcom/google/mlkit/vision/text/TextRecognizer;

    move-result-object v1

    .line 369
    .local v1, "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    :try_start_0
    invoke-static {p0, p1}, Lcom/google/mlkit/vision/common/InputImage;->fromFilePath(Landroid/content/Context;Landroid/net/Uri;)Lcom/google/mlkit/vision/common/InputImage;

    move-result-object v2

    .line 370
    .local v2, "image":Lcom/google/mlkit/vision/common/InputImage;
    invoke-interface {v1, v2}, Lcom/google/mlkit/vision/text/TextRecognizer;->process(Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/tasks/Task;

    move-result-object v3

    new-instance v4, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;

    invoke-direct {v4, p0, v1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;-><init>(Lcom/blink/app/MainActivity;Lcom/google/mlkit/vision/text/TextRecognizer;)V

    .line 371
    invoke-virtual {v3, v4}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    move-result-object v3

    new-instance v4, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda5;

    invoke-direct {v4, p0, v1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda5;-><init>(Lcom/blink/app/MainActivity;Lcom/google/mlkit/vision/text/TextRecognizer;)V

    .line 375
    invoke-virtual {v3, v4}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 384
    nop

    .end local v2    # "image":Lcom/google/mlkit/vision/common/InputImage;
    goto :goto_0

    .line 380
    :catch_0
    move-exception v2

    .line 381
    .local v2, "error":Ljava/lang/Exception;
    invoke-interface {v1}, Lcom/google/mlkit/vision/text/TextRecognizer;->close()V

    .line 382
    const-string v3, "BLINK"

    const-string v4, "Could not open the selected timetable image."

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 383
    const-string v3, "Could not open this image for on-device text recognition."

    invoke-direct {p0, v3}, Lcom/blink/app/MainActivity;->deliverScheduleOcrError(Ljava/lang/String;)V

    .line 385
    .end local v2    # "error":Ljava/lang/Exception;
    :goto_0
    return-void

    .line 364
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    :cond_1
    :goto_1
    invoke-direct {p0, p1}, Lcom/blink/app/MainActivity;->extractPdfText(Landroid/net/Uri;)V

    .line 365
    return-void
.end method

.method private isAllowedAppNavigation(Landroid/net/Uri;)Z
    .locals 5
    .param p1, "uri"    # Landroid/net/Uri;

    .line 232
    const-string v0, "https"

    invoke-virtual {p1}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 233
    :cond_0
    invoke-virtual {p1}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v0

    .line 234
    .local v0, "host":Ljava/lang/String;
    const-string v2, "appassets.androidplatform.net"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x1

    if-nez v2, :cond_3

    .line 235
    const-string v2, "accounts.google.com"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_1

    .line 238
    :cond_1
    const-string v2, "blink-8ac05.firebaseapp.com"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 239
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 240
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    const-string v4, "/__/auth/"

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    move v1, v3

    goto :goto_0

    :cond_2
    nop

    .line 238
    :goto_0
    return v1

    .line 236
    :cond_3
    :goto_1
    return v3
.end method

.method private synthetic lambda$deliverGoogleSignInResult$4(Ljava/lang/String;)V
    .locals 2
    .param p1, "callback"    # Ljava/lang/String;

    .line 358
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method private synthetic lambda$deliverScheduleOcr$9(Ljava/lang/String;)V
    .locals 3
    .param p1, "safeText"    # Ljava/lang/String;

    .line 449
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "(()=>{const frame=document.querySelector(\'iframe\');const app=frame?.contentWindow||window;app.BlinkCollegeScheduleManager?.importOcrText("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")})()"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method private synthetic lambda$deliverScheduleOcrError$10(Ljava/lang/String;)V
    .locals 3
    .param p1, "safeMessage"    # Ljava/lang/String;

    .line 457
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "(()=>{const frame=document.querySelector(\'iframe\');const app=frame?.contentWindow||window;app.BlinkCollegeScheduleManager?.onOcrError("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")})()"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method private synthetic lambda$explainBackgroundLocation$14(Landroid/content/DialogInterface;I)V
    .locals 1
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .line 639
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 640
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/blink/app/MainActivity;->startTrackingService()V

    .line 641
    :cond_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 642
    return-void
.end method

.method private synthetic lambda$explainBackgroundLocation$15(Landroid/content/DialogInterface;I)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .line 644
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 645
    new-instance v0, Landroid/content/Intent;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "package:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 646
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const-string v3, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {v0, v3, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 647
    .local v0, "intent":Landroid/content/Intent;
    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 648
    iput-boolean v2, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 649
    .end local v0    # "intent":Landroid/content/Intent;
    goto :goto_0

    .line 650
    :cond_0
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "android.permission.ACCESS_BACKGROUND_LOCATION"

    aput-object v1, v0, v2

    const/16 v1, 0xc

    invoke-virtual {p0, v0, v1}, Lcom/blink/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 653
    :goto_0
    return-void
.end method

.method private synthetic lambda$extractPdfText$7(Landroid/net/Uri;)V
    .locals 13
    .param p1, "uri"    # Landroid/net/Uri;

    .line 389
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 390
    .local v0, "text":Ljava/lang/StringBuilder;
    sget-object v1, Lcom/google/mlkit/vision/text/latin/TextRecognizerOptions;->DEFAULT_OPTIONS:Lcom/google/mlkit/vision/text/latin/TextRecognizerOptions;

    invoke-static {v1}, Lcom/google/mlkit/vision/text/TextRecognition;->getClient(Lcom/google/mlkit/vision/text/TextRecognizerOptionsInterface;)Lcom/google/mlkit/vision/text/TextRecognizer;

    move-result-object v1

    .line 391
    .local v1, "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    :try_start_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "r"

    invoke-virtual {v2, p1, v3}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_7

    .line 392
    .local v2, "descriptor":Landroid/os/ParcelFileDescriptor;
    const/4 v3, 0x0

    if-nez v2, :cond_0

    move-object v4, v3

    goto :goto_0

    :cond_0
    :try_start_1
    new-instance v4, Landroid/graphics/pdf/PdfRenderer;

    invoke-direct {v4, v2}, Landroid/graphics/pdf/PdfRenderer;-><init>(Landroid/os/ParcelFileDescriptor;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_5

    .line 393
    .local v4, "renderer":Landroid/graphics/pdf/PdfRenderer;
    :goto_0
    if-eqz v4, :cond_b

    .line 394
    :try_start_2
    invoke-virtual {v4}, Landroid/graphics/pdf/PdfRenderer;->getPageCount()I

    move-result v5

    const/16 v6, 0x32

    if-le v5, v6, :cond_3

    .line 395
    const-string v3, "This PDF has more than 50 pages. Split it and import the timetable pages."

    invoke-direct {p0, v3}, Lcom/blink/app/MainActivity;->deliverScheduleOcrError(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 418
    if-eqz v4, :cond_1

    :try_start_3
    invoke-virtual {v4}, Landroid/graphics/pdf/PdfRenderer;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_5

    :cond_1
    if-eqz v2, :cond_2

    :try_start_4
    invoke-virtual {v2}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_7

    .line 423
    :cond_2
    invoke-interface {v1}, Lcom/google/mlkit/vision/text/TextRecognizer;->close()V

    .line 396
    return-void

    .line 398
    :cond_3
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_1
    :try_start_5
    invoke-virtual {v4}, Landroid/graphics/pdf/PdfRenderer;->getPageCount()I

    move-result v6

    if-ge v5, v6, :cond_8

    .line 399
    invoke-virtual {v4, v5}, Landroid/graphics/pdf/PdfRenderer;->openPage(I)Landroid/graphics/pdf/PdfRenderer$Page;

    move-result-object v6
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 400
    .local v6, "page":Landroid/graphics/pdf/PdfRenderer$Page;
    :try_start_6
    invoke-virtual {v6}, Landroid/graphics/pdf/PdfRenderer$Page;->getWidth()I

    move-result v7

    invoke-virtual {v6}, Landroid/graphics/pdf/PdfRenderer$Page;->getHeight()I

    move-result v8

    invoke-static {v7, v8}, Ljava/lang/Math;->max(II)I

    move-result v7

    int-to-float v7, v7

    const/high16 v8, 0x44e10000    # 1800.0f

    div-float/2addr v8, v7

    const/high16 v7, 0x40200000    # 2.5f

    invoke-static {v7, v8}, Ljava/lang/Math;->min(FF)F

    move-result v7

    .line 401
    .local v7, "scale":F
    invoke-virtual {v6}, Landroid/graphics/pdf/PdfRenderer$Page;->getWidth()I

    move-result v8

    int-to-float v8, v8

    mul-float/2addr v8, v7

    invoke-static {v8}, Ljava/lang/Math;->round(F)I

    move-result v8

    const/4 v9, 0x1

    invoke-static {v9, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    .line 402
    .local v8, "width":I
    invoke-virtual {v6}, Landroid/graphics/pdf/PdfRenderer$Page;->getHeight()I

    move-result v10

    int-to-float v10, v10

    mul-float/2addr v10, v7

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v10

    invoke-static {v9, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 403
    .local v10, "height":I
    sget-object v11, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v8, v10, v11}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v11
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 405
    .local v11, "bitmap":Landroid/graphics/Bitmap;
    :try_start_7
    invoke-virtual {v6, v11, v3, v3, v9}, Landroid/graphics/pdf/PdfRenderer$Page;->render(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Matrix;I)V

    .line 406
    const/4 v9, 0x0

    invoke-static {v11, v9}, Lcom/google/mlkit/vision/common/InputImage;->fromBitmap(Landroid/graphics/Bitmap;I)Lcom/google/mlkit/vision/common/InputImage;

    move-result-object v9

    invoke-interface {v1, v9}, Lcom/google/mlkit/vision/text/TextRecognizer;->process(Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/tasks/Task;

    move-result-object v9

    invoke-static {v9}, Lcom/google/android/gms/tasks/Tasks;->await(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/google/mlkit/vision/text/Text;

    invoke-virtual {v9}, Lcom/google/mlkit/vision/text/Text;->getText()Ljava/lang/String;

    move-result-object v9

    .line 407
    .local v9, "pageText":Ljava/lang/String;
    invoke-static {v9}, Lcom/blink/app/MainActivity$$ExternalSyntheticBackport0;->m(Ljava/lang/String;)Z

    move-result v12

    if-nez v12, :cond_5

    .line 408
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v12

    if-lez v12, :cond_4

    const/16 v12, 0xa

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 409
    :cond_4
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 412
    .end local v9    # "pageText":Ljava/lang/String;
    :cond_5
    :try_start_8
    invoke-virtual {v11}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 413
    nop

    .line 414
    .end local v7    # "scale":F
    .end local v8    # "width":I
    .end local v10    # "height":I
    .end local v11    # "bitmap":Landroid/graphics/Bitmap;
    if-eqz v6, :cond_6

    :try_start_9
    invoke-virtual {v6}, Landroid/graphics/pdf/PdfRenderer$Page;->close()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    .line 398
    .end local v6    # "page":Landroid/graphics/pdf/PdfRenderer$Page;
    :cond_6
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 412
    .restart local v6    # "page":Landroid/graphics/pdf/PdfRenderer$Page;
    .restart local v7    # "scale":F
    .restart local v8    # "width":I
    .restart local v10    # "height":I
    .restart local v11    # "bitmap":Landroid/graphics/Bitmap;
    :catchall_0
    move-exception v3

    :try_start_a
    invoke-virtual {v11}, Landroid/graphics/Bitmap;->recycle()V

    .line 413
    nop

    .end local v0    # "text":Ljava/lang/StringBuilder;
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .end local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .end local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .end local v5    # "index":I
    .end local v6    # "page":Landroid/graphics/pdf/PdfRenderer$Page;
    .end local p1    # "uri":Landroid/net/Uri;
    throw v3
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    .line 399
    .end local v7    # "scale":F
    .end local v8    # "width":I
    .end local v10    # "height":I
    .end local v11    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v0    # "text":Ljava/lang/StringBuilder;
    .restart local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .restart local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .restart local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .restart local v5    # "index":I
    .restart local v6    # "page":Landroid/graphics/pdf/PdfRenderer$Page;
    .restart local p1    # "uri":Landroid/net/Uri;
    :catchall_1
    move-exception v3

    if-eqz v6, :cond_7

    :try_start_b
    invoke-virtual {v6}, Landroid/graphics/pdf/PdfRenderer$Page;->close()V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    goto :goto_2

    :catchall_2
    move-exception v7

    :try_start_c
    invoke-virtual {v3, v7}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "text":Ljava/lang/StringBuilder;
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .end local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .end local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .end local p1    # "uri":Landroid/net/Uri;
    :cond_7
    :goto_2
    throw v3

    .line 416
    .end local v5    # "index":I
    .end local v6    # "page":Landroid/graphics/pdf/PdfRenderer$Page;
    .restart local v0    # "text":Ljava/lang/StringBuilder;
    .restart local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .restart local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .restart local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .restart local p1    # "uri":Landroid/net/Uri;
    :cond_8
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-eqz v3, :cond_a

    .line 417
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/blink/app/MainActivity;->deliverScheduleOcr(Ljava/lang/String;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    .line 418
    if-eqz v4, :cond_9

    :try_start_d
    invoke-virtual {v4}, Landroid/graphics/pdf/PdfRenderer;->close()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_5

    .end local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    :cond_9
    if-eqz v2, :cond_f

    :try_start_e
    invoke-virtual {v2}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_0
    .catchall {:try_start_e .. :try_end_e} :catchall_7

    goto :goto_7

    .line 416
    .restart local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    :cond_a
    :try_start_f
    new-instance v3, Ljava/io/IOException;

    const-string v5, "No readable text was found in this PDF."

    invoke-direct {v3, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "text":Ljava/lang/StringBuilder;
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .end local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .end local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .end local p1    # "uri":Landroid/net/Uri;
    throw v3

    .line 391
    .restart local v0    # "text":Ljava/lang/StringBuilder;
    .restart local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .restart local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .restart local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .restart local p1    # "uri":Landroid/net/Uri;
    :catchall_3
    move-exception v3

    goto :goto_3

    .line 393
    :cond_b
    new-instance v3, Ljava/io/IOException;

    const-string v5, "Could not open this PDF."

    invoke-direct {v3, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "text":Ljava/lang/StringBuilder;
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .end local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .end local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .end local p1    # "uri":Landroid/net/Uri;
    throw v3
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_3

    .line 391
    .restart local v0    # "text":Ljava/lang/StringBuilder;
    .restart local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .restart local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .restart local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .restart local p1    # "uri":Landroid/net/Uri;
    :goto_3
    if-eqz v4, :cond_c

    :try_start_10
    invoke-virtual {v4}, Landroid/graphics/pdf/PdfRenderer;->close()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_4

    goto :goto_4

    :catchall_4
    move-exception v5

    :try_start_11
    invoke-virtual {v3, v5}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "text":Ljava/lang/StringBuilder;
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .end local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .end local p1    # "uri":Landroid/net/Uri;
    :cond_c
    :goto_4
    throw v3
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_5

    .end local v4    # "renderer":Landroid/graphics/pdf/PdfRenderer;
    .restart local v0    # "text":Ljava/lang/StringBuilder;
    .restart local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .restart local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .restart local p1    # "uri":Landroid/net/Uri;
    :catchall_5
    move-exception v3

    if-eqz v2, :cond_d

    :try_start_12
    invoke-virtual {v2}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_6

    goto :goto_5

    :catchall_6
    move-exception v4

    :try_start_13
    invoke-virtual {v3, v4}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "text":Ljava/lang/StringBuilder;
    .end local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .end local p1    # "uri":Landroid/net/Uri;
    :cond_d
    :goto_5
    throw v3
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_0
    .catchall {:try_start_13 .. :try_end_13} :catchall_7

    .line 423
    .end local v2    # "descriptor":Landroid/os/ParcelFileDescriptor;
    .restart local v0    # "text":Ljava/lang/StringBuilder;
    .restart local v1    # "recognizer":Lcom/google/mlkit/vision/text/TextRecognizer;
    .restart local p1    # "uri":Landroid/net/Uri;
    :catchall_7
    move-exception v2

    goto :goto_8

    .line 418
    :catch_0
    move-exception v2

    .line 419
    .local v2, "error":Ljava/lang/Exception;
    :try_start_14
    const-string v3, "BLINK"

    const-string v4, "On-device timetable PDF OCR failed."

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 420
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_e

    .line 421
    const-string v3, "Could not extract timetable text from this PDF."

    goto :goto_6

    :cond_e
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    .line 420
    :goto_6
    invoke-direct {p0, v3}, Lcom/blink/app/MainActivity;->deliverScheduleOcrError(Ljava/lang/String;)V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_7

    .line 423
    .end local v2    # "error":Ljava/lang/Exception;
    :cond_f
    :goto_7
    invoke-interface {v1}, Lcom/google/mlkit/vision/text/TextRecognizer;->close()V

    .line 424
    nop

    .line 425
    return-void

    .line 423
    :goto_8
    invoke-interface {v1}, Lcom/google/mlkit/vision/text/TextRecognizer;->close()V

    .line 424
    throw v2
.end method

.method private synthetic lambda$extractScheduleText$5(Lcom/google/mlkit/vision/text/TextRecognizer;Lcom/google/mlkit/vision/text/Text;)V
    .locals 1
    .param p1, "recognizer"    # Lcom/google/mlkit/vision/text/TextRecognizer;
    .param p2, "result"    # Lcom/google/mlkit/vision/text/Text;

    .line 372
    invoke-interface {p1}, Lcom/google/mlkit/vision/text/TextRecognizer;->close()V

    .line 373
    invoke-virtual {p2}, Lcom/google/mlkit/vision/text/Text;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/blink/app/MainActivity;->deliverScheduleOcr(Ljava/lang/String;)V

    .line 374
    return-void
.end method

.method private synthetic lambda$extractScheduleText$6(Lcom/google/mlkit/vision/text/TextRecognizer;Ljava/lang/Exception;)V
    .locals 2
    .param p1, "recognizer"    # Lcom/google/mlkit/vision/text/TextRecognizer;
    .param p2, "error"    # Ljava/lang/Exception;

    .line 376
    invoke-interface {p1}, Lcom/google/mlkit/vision/text/TextRecognizer;->close()V

    .line 377
    const-string v0, "BLINK"

    const-string v1, "On-device timetable image OCR failed."

    invoke-static {v0, v1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 378
    const-string v0, "Could not read text from this image. Try a clearer image."

    invoke-direct {p0, v0}, Lcom/blink/app/MainActivity;->deliverScheduleOcrError(Ljava/lang/String;)V

    .line 379
    return-void
.end method

.method private synthetic lambda$notifyScheduleBackup$11(ZLjava/lang/String;)V
    .locals 3
    .param p1, "success"    # Z
    .param p2, "safeMessage"    # Ljava/lang/String;

    .line 465
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "(()=>{const frame=document.querySelector(\'iframe\');const app=frame?.contentWindow||window;app.BlinkCollegeScheduleManager?.onBackupResult("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")})()"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method static synthetic lambda$onCreate$0(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 4
    .param p0, "view"    # Landroid/view/View;
    .param p1, "insets"    # Landroid/view/WindowInsets;

    .line 113
    invoke-virtual {p1}, Landroid/view/WindowInsets;->getSystemWindowInsetLeft()I

    move-result v0

    invoke-virtual {p1}, Landroid/view/WindowInsets;->getSystemWindowInsetTop()I

    move-result v1

    .line 114
    invoke-virtual {p1}, Landroid/view/WindowInsets;->getSystemWindowInsetRight()I

    move-result v2

    invoke-virtual {p1}, Landroid/view/WindowInsets;->getSystemWindowInsetBottom()I

    move-result v3

    .line 113
    invoke-virtual {p0, v0, v1, v2, v3}, Landroid/view/View;->setPadding(IIII)V

    .line 115
    invoke-virtual {p1}, Landroid/view/WindowInsets;->consumeSystemWindowInsets()Landroid/view/WindowInsets;

    move-result-object v0

    return-object v0
.end method

.method private synthetic lambda$onResume$13()V
    .locals 3

    .line 559
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    const-string v1, "(()=>{window.dispatchEvent(new Event(\'blink:native-resume\'));const f=document.querySelector(\'iframe\');if(f)f.contentWindow.dispatchEvent(new Event(\'blink:native-resume\'))})()"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method private synthetic lambda$publishTrackingUpdate$17()V
    .locals 3

    .line 819
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    const-string v1, "(()=>{window.dispatchEvent(new Event(\'blink:native-update\'));const f=document.querySelector(\'iframe\');if(f)f.contentWindow.dispatchEvent(new Event(\'blink:native-update\'))})()"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method private synthetic lambda$requestGoogleSignIn$2(Ljava/lang/String;)V
    .locals 4
    .param p1, "requestId"    # Ljava/lang/String;

    .line 329
    iget-object v0, p0, Lcom/blink/app/MainActivity;->pendingGoogleSignInRequest:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 330
    const-string v0, "Google sign-in is already in progress."

    invoke-direct {p0, p1, v1, v0}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 331
    return-void

    .line 333
    :cond_0
    iput-object p1, p0, Lcom/blink/app/MainActivity;->pendingGoogleSignInRequest:Ljava/lang/String;

    .line 335
    :try_start_0
    iget-object v0, p0, Lcom/blink/app/MainActivity;->googleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;->getSignInIntent()Landroid/content/Intent;

    move-result-object v0

    const/16 v2, 0x10

    invoke-virtual {p0, v0, v2}, Lcom/blink/app/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 340
    goto :goto_0

    .line 336
    :catch_0
    move-exception v0

    .line 337
    .local v0, "error":Landroid/content/ActivityNotFoundException;
    iput-object v1, p0, Lcom/blink/app/MainActivity;->pendingGoogleSignInRequest:Ljava/lang/String;

    .line 338
    const-string v2, "BLINK"

    const-string v3, "Google sign-in activity is unavailable."

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 339
    const-string v2, "Google sign-in is unavailable on this device."

    invoke-direct {p0, p1, v1, v2}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 341
    .end local v0    # "error":Landroid/content/ActivityNotFoundException;
    :goto_0
    return-void
.end method

.method private synthetic lambda$saveScheduleBackup$8(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "contents"    # Ljava/lang/String;
    .param p2, "filename"    # Ljava/lang/String;

    .line 430
    iput-object p1, p0, Lcom/blink/app/MainActivity;->pendingScheduleBackup:Ljava/lang/String;

    .line 431
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 432
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 433
    const-string v1, "application/json"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 434
    if-eqz p2, :cond_1

    invoke-static {p2}, Lcom/blink/app/MainActivity$$ExternalSyntheticBackport0;->m(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 435
    :cond_0
    move-object v1, p2

    goto :goto_1

    :cond_1
    :goto_0
    const-string v1, "blink-schedules.json"

    .line 434
    :goto_1
    const-string v2, "android.intent.extra.TITLE"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 437
    .local v0, "save":Landroid/content/Intent;
    const/16 v1, 0xf

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/blink/app/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 442
    goto :goto_2

    .line 438
    :catch_0
    move-exception v1

    .line 439
    .local v1, "error":Landroid/content/ActivityNotFoundException;
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/blink/app/MainActivity;->pendingScheduleBackup:Ljava/lang/String;

    .line 440
    const-string v2, "BLINK"

    const-string v3, "No document provider is available to save schedule backup."

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 441
    const/4 v2, 0x0

    const-string v3, "No file destination is available."

    invoke-direct {p0, v2, v3}, Lcom/blink/app/MainActivity;->notifyScheduleBackup(ZLjava/lang/String;)V

    .line 443
    .end local v1    # "error":Landroid/content/ActivityNotFoundException;
    :goto_2
    return-void
.end method

.method private synthetic lambda$selectScheduleFile$1(Ljava/lang/String;)V
    .locals 5
    .param p1, "kind"    # Ljava/lang/String;

    .line 245
    const-string v0, "pdf"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    .line 246
    .local v0, "pdf":Z
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/blink/app/MainActivity;->pendingScheduleOcr:Z

    .line 247
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/blink/app/MainActivity;->pendingFileChooser:Landroid/webkit/ValueCallback;

    .line 248
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 249
    const-string v2, "android.intent.category.OPENABLE"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    .line 250
    if-eqz v0, :cond_0

    const-string v2, "application/pdf"

    goto :goto_0

    :cond_0
    const-string v2, "image/*"

    :goto_0
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    .line 252
    .local v1, "picker":Landroid/content/Intent;
    const/16 v2, 0xe

    :try_start_0
    invoke-virtual {p0, v1, v2}, Lcom/blink/app/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 257
    goto :goto_1

    .line 253
    :catch_0
    move-exception v2

    .line 254
    .local v2, "error":Landroid/content/ActivityNotFoundException;
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/blink/app/MainActivity;->pendingScheduleOcr:Z

    .line 255
    const-string v3, "BLINK"

    const-string v4, "No document picker is available for schedule OCR."

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 256
    const-string v3, "No file picker is available on this device."

    invoke-direct {p0, v3}, Lcom/blink/app/MainActivity;->deliverScheduleOcrError(Ljava/lang/String;)V

    .line 258
    .end local v2    # "error":Landroid/content/ActivityNotFoundException;
    :goto_1
    return-void
.end method

.method private synthetic lambda$showNotification$16(Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    .line 801
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasNotificationPermission()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 802
    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/MainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 803
    .local v0, "open":Landroid/content/Intent;
    const/high16 v1, 0xc000000

    const/4 v2, 0x1

    invoke-static {p0, v2, v0, v1}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 805
    .local v1, "pending":Landroid/app/PendingIntent;
    new-instance v3, Landroidx/core/app/NotificationCompat$Builder;

    const-string v4, "blink_reminders"

    invoke-direct {v3, p0, v4}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 807
    const v4, 0x108009b

    invoke-virtual {v3, v4}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v3

    const v4, -0xfd2be

    invoke-virtual {v3, v4}, Landroidx/core/app/NotificationCompat$Builder;->setColor(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v3

    .line 808
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_1

    goto :goto_0

    :cond_1
    move-object v4, p1

    goto :goto_1

    :cond_2
    :goto_0
    const-string v4, "BLINK"

    :goto_1
    invoke-virtual {v3, v4}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v3

    .line 809
    if-nez p2, :cond_3

    const-string v4, ""

    goto :goto_2

    :cond_3
    move-object v4, p2

    :goto_2
    invoke-virtual {v3, v4}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v3

    .line 810
    invoke-virtual {v3, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v3

    .line 811
    invoke-virtual {v3, v2}, Landroidx/core/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v2

    .line 812
    invoke-virtual {v2}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    .line 813
    .local v2, "notification":Landroid/app/Notification;
    const-class v3, Landroid/app/NotificationManager;

    invoke-virtual {p0, v3}, Lcom/blink/app/MainActivity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/NotificationManager;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-wide/32 v6, 0x7fffffff

    and-long/2addr v4, v6

    long-to-int v4, v4

    invoke-virtual {v3, v4, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 814
    return-void
.end method

.method static synthetic lambda$signOutGoogle$3(Ljava/lang/Exception;)V
    .locals 2
    .param p0, "error"    # Ljava/lang/Exception;

    .line 346
    const-string v0, "BLINK"

    const-string v1, "Could not clear the native Google sign-in session."

    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method static synthetic lambda$startSplashAnimation$12([Landroid/widget/TextView;Landroid/animation/ValueAnimator;)V
    .locals 17
    .param p0, "characters"    # [Landroid/widget/TextView;
    .param p1, "valueAnimator"    # Landroid/animation/ValueAnimator;

    .line 508
    move-object/from16 v0, p0

    invoke-virtual/range {p1 .. p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->longValue()J

    move-result-wide v1

    .line 509
    .local v1, "elapsed":J
    const/4 v3, 0x0

    .local v3, "index":I
    :goto_0
    array-length v4, v0

    if-ge v3, v4, :cond_1

    .line 510
    aget-object v4, v0, v3

    .line 511
    .local v4, "character":Landroid/widget/TextView;
    int-to-long v5, v3

    const-wide/16 v7, 0x64

    mul-long/2addr v5, v7

    const-wide/16 v7, 0xaa

    add-long/2addr v5, v7

    .line 512
    .local v5, "revealAt":J
    cmp-long v7, v1, v5

    const/high16 v8, 0x3f800000    # 1.0f

    if-ltz v7, :cond_0

    .line 513
    const-string v7, "BLINK"

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v7}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 514
    sub-long v9, v1, v5

    long-to-float v7, v9

    const/high16 v9, 0x42b40000    # 90.0f

    div-float/2addr v7, v9

    invoke-static {v8, v7}, Ljava/lang/Math;->min(FF)F

    move-result v7

    .line 515
    .local v7, "revealProgress":F
    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setAlpha(F)V

    .line 516
    const v8, 0x3e3851ec    # 0.18f

    mul-float/2addr v8, v7

    const v9, 0x3f51eb85    # 0.82f

    add-float/2addr v8, v9

    .line 517
    .local v8, "scale":F
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setScaleX(F)V

    .line 518
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setScaleY(F)V

    .line 519
    .end local v7    # "revealProgress":F
    .end local v8    # "scale":F
    goto :goto_1

    .line 520
    :cond_0
    const-wide/16 v9, 0x2d

    div-long v9, v1, v9

    .line 521
    .local v9, "frame":J
    const-wide/16 v11, 0xb

    mul-long/2addr v11, v9

    int-to-long v13, v3

    const-wide/16 v15, 0x7

    mul-long/2addr v13, v15

    add-long/2addr v11, v13

    const-wide/16 v13, 0xd

    div-long v13, v1, v13

    add-long/2addr v11, v13

    sget-object v7, Lcom/blink/app/MainActivity;->SCRAMBLE_CHARS:[C

    array-length v7, v7

    int-to-long v13, v7

    rem-long/2addr v11, v13

    long-to-int v7, v11

    .line 523
    .local v7, "scrambleIndex":I
    sget-object v11, Lcom/blink/app/MainActivity;->SCRAMBLE_CHARS:[C

    aget-char v11, v11, v7

    invoke-static {v11}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 524
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setAlpha(F)V

    .line 525
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setScaleX(F)V

    .line 526
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setScaleY(F)V

    .line 509
    .end local v4    # "character":Landroid/widget/TextView;
    .end local v5    # "revealAt":J
    .end local v7    # "scrambleIndex":I
    .end local v9    # "frame":J
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 529
    .end local v3    # "index":I
    :cond_1
    return-void
.end method

.method private notifyScheduleBackup(ZLjava/lang/String;)V
    .locals 3
    .param p1, "success"    # Z
    .param p2, "message"    # Ljava/lang/String;

    .line 463
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 464
    :cond_0
    invoke-static {p2}, Lorg/json/JSONObject;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 465
    .local v0, "safeMessage":Ljava/lang/String;
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda10;

    invoke-direct {v2, p0, p1, v0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda10;-><init>(Lcom/blink/app/MainActivity;ZLjava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 468
    return-void
.end method

.method private registerGymGeofence()V
    .locals 2

    .line 743
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasBackgroundLocationPermission()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 744
    :cond_0
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/blink/app/MainActivity;->geofencingClient:Lcom/google/android/gms/location/GeofencingClient;

    invoke-virtual {v0, p0, v1}, Lcom/blink/app/TrackingStore;->registerGymGeofence(Landroid/content/Context;Lcom/google/android/gms/location/GeofencingClient;)V

    .line 745
    return-void

    .line 743
    :cond_1
    :goto_0
    return-void
.end method

.method private removeGymGeofence()V
    .locals 2

    .line 748
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/blink/app/MainActivity;->geofencingClient:Lcom/google/android/gms/location/GeofencingClient;

    invoke-virtual {v0, v1}, Lcom/blink/app/TrackingStore;->removeGymGeofence(Lcom/google/android/gms/location/GeofencingClient;)V

    .line 749
    return-void
.end method

.method private requestNotificationPermissionIfNeeded()V
    .locals 0

    .line 673
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->requestClassReminderPermission()V

    .line 674
    return-void
.end method

.method private startSplashAnimation()V
    .locals 5

    .line 498
    iget-object v0, p0, Lcom/blink/app/MainActivity;->splashOverlay:Landroid/widget/FrameLayout;

    if-nez v0, :cond_0

    return-void

    .line 499
    :cond_0
    iget-object v0, p0, Lcom/blink/app/MainActivity;->splashOverlay:Landroid/widget/FrameLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 500
    .local v0, "wordmark":Landroid/widget/LinearLayout;
    const-string v1, "BLINK"

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    new-array v1, v1, [Landroid/widget/TextView;

    .line 501
    .local v1, "characters":[Landroid/widget/TextView;
    const/4 v2, 0x0

    .local v2, "index":I
    :goto_0
    array-length v3, v1

    if-ge v2, v3, :cond_1

    .line 502
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    aput-object v3, v1, v2

    .line 501
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 504
    .end local v2    # "index":I
    :cond_1
    const/4 v2, 0x2

    new-array v2, v2, [F

    fill-array-data v2, :array_0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 505
    .local v2, "animator":Landroid/animation/ValueAnimator;
    const-wide/16 v3, 0x2bc

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 506
    new-instance v3, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v3}, Landroid/view/animation/LinearInterpolator;-><init>()V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 507
    new-instance v3, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda8;

    invoke-direct {v3, v1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda8;-><init>([Landroid/widget/TextView;)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 530
    new-instance v3, Lcom/blink/app/MainActivity$3;

    invoke-direct {v3, p0, v1}, Lcom/blink/app/MainActivity$3;-><init>(Lcom/blink/app/MainActivity;[Landroid/widget/TextView;)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 545
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 546
    return-void

    :array_0
    .array-data 4
        0x0
        0x442f0000    # 700.0f
    .end array-data
.end method

.method private startTrackingService()V
    .locals 4

    .line 729
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 730
    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/blink/app/LocationTrackingService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 731
    const-string v1, "com.blink.app.START_TRACKING"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 733
    .local v0, "intent":Landroid/content/Intent;
    :try_start_0
    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 739
    goto :goto_1

    .line 735
    :catch_0
    move-exception v1

    .line 736
    .local v1, "error":Ljava/lang/RuntimeException;
    new-instance v2, Lcom/blink/app/TrackingStore;

    invoke-direct {v2, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 737
    .local v2, "store":Lcom/blink/app/TrackingStore;
    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    const-string v3, "Android could not start location tracking."

    goto :goto_0

    :cond_1
    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v3

    :goto_0
    invoke-virtual {v2, v3}, Lcom/blink/app/TrackingStore;->setServiceError(Ljava/lang/String;)V

    .line 738
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 740
    .end local v1    # "error":Ljava/lang/RuntimeException;
    .end local v2    # "store":Lcom/blink/app/TrackingStore;
    :goto_1
    return-void
.end method


# virtual methods
.method appUsageTodayJson()Ljava/lang/String;
    .locals 1

    .line 762
    new-instance v0, Lcom/blink/app/UsageSleepEstimator;

    invoke-direct {v0, p0}, Lcom/blink/app/UsageSleepEstimator;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/blink/app/UsageSleepEstimator;->appUsageToday()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method applySyncedGymLocation(DDF)V
    .locals 7
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F

    .line 849
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    move-object v1, v0

    .line 850
    .local v1, "store":Lcom/blink/app/TrackingStore;
    move-wide v2, p1

    move-wide v4, p3

    move v6, p5

    .end local p1    # "latitude":D
    .end local p3    # "longitude":D
    .end local p5    # "radiusMeters":F
    .local v2, "latitude":D
    .local v4, "longitude":D
    .local v6, "radiusMeters":F
    invoke-virtual/range {v1 .. v6}, Lcom/blink/app/TrackingStore;->setGymLocation(DDF)V

    .line 851
    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasBackgroundLocationPermission()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->hasGymLocation()Z

    move-result p1

    if-eqz p1, :cond_0

    .line 852
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->registerGymGeofence()V

    .line 854
    :cond_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 855
    return-void
.end method

.method applySyncedTrackingSettings(ZZZZD)V
    .locals 8
    .param p1, "locationEnabled"    # Z
    .param p2, "activityEnabled"    # Z
    .param p3, "gymEnabled"    # Z
    .param p4, "sleepEnabled"    # Z
    .param p5, "sleepTargetHours"    # D

    .line 870
    move v2, p1

    .line 871
    .end local p1    # "locationEnabled":Z
    .local v2, "locationEnabled":Z
    new-instance v1, Lcom/blink/app/TrackingStore;

    invoke-direct {v1, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 872
    .local v1, "store":Lcom/blink/app/TrackingStore;
    move v3, p2

    move v4, p3

    move v5, p4

    move-wide v6, p5

    .end local p2    # "activityEnabled":Z
    .end local p3    # "gymEnabled":Z
    .end local p4    # "sleepEnabled":Z
    .end local p5    # "sleepTargetHours":D
    .local v3, "activityEnabled":Z
    .local v4, "gymEnabled":Z
    .local v5, "sleepEnabled":Z
    .local v6, "sleepTargetHours":D
    invoke-virtual/range {v1 .. v7}, Lcom/blink/app/TrackingStore;->setTrackingSettings(ZZZZD)V

    .line 873
    if-nez v2, :cond_0

    .line 874
    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->finishCardio()V

    .line 875
    new-instance p1, Landroid/content/Intent;

    const-class p2, Lcom/blink/app/LocationTrackingService;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Lcom/blink/app/MainActivity;->stopService(Landroid/content/Intent;)Z

    .line 876
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->removeGymGeofence()V

    goto :goto_0

    .line 877
    :cond_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result p1

    if-eqz p1, :cond_1

    .line 878
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    .line 880
    :cond_1
    :goto_0
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    if-eqz v4, :cond_2

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasBackgroundLocationPermission()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->hasGymLocation()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0}, Lcom/blink/app/MainActivity;->registerGymGeofence()V

    .line 881
    :cond_2
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 882
    return-void
.end method

.method applyTrackingSettings(ZZZZD)V
    .locals 10
    .param p1, "locationEnabled"    # Z
    .param p2, "activityEnabled"    # Z
    .param p3, "gymEnabled"    # Z
    .param p4, "sleepEnabled"    # Z
    .param p5, "sleepTargetHours"    # D

    .line 584
    const/4 v0, 0x1

    const/4 v1, 0x0

    move v4, p1

    .line 585
    .end local p1    # "locationEnabled":Z
    .local v4, "locationEnabled":Z
    new-instance v3, Lcom/blink/app/TrackingStore;

    invoke-direct {v3, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 586
    .local v3, "store":Lcom/blink/app/TrackingStore;
    move v5, p2

    move v6, p3

    move v7, p4

    move-wide v8, p5

    invoke-virtual/range {v3 .. v9}, Lcom/blink/app/TrackingStore;->setTrackingSettings(ZZZZD)V

    .line 587
    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 588
    iput-boolean v1, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    .line 589
    if-nez v4, :cond_0

    .line 590
    invoke-virtual {v3}, Lcom/blink/app/TrackingStore;->finishCardio()V

    .line 591
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/blink/app/LocationTrackingService;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Lcom/blink/app/MainActivity;->stopService(Landroid/content/Intent;)Z

    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    .line 592
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->removeGymGeofence()V

    .line 593
    iput-boolean v1, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 594
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 595
    return-void

    .line 597
    :cond_0
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->continuePermissionFlow()V

    .line 598
    return-void
.end method

.method currentLocationJson()Ljava/lang/String;
    .locals 13

    .line 766
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v0

    .line 767
    .local v0, "precise":Z
    const-string v1, "null"

    if-nez v0, :cond_0

    const-string v2, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-virtual {p0, v2}, Lcom/blink/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    .line 768
    return-object v1

    .line 769
    :cond_0
    const-string v2, "location"

    invoke-virtual {p0, v2}, Lcom/blink/app/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/location/LocationManager;

    .line 770
    .local v2, "manager":Landroid/location/LocationManager;
    if-nez v2, :cond_1

    return-object v1

    .line 772
    :cond_1
    :try_start_0
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1c

    if-lt v3, v4, :cond_2

    invoke-virtual {v2}, Landroid/location/LocationManager;->isLocationEnabled()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v3, :cond_2

    return-object v1

    .line 773
    :cond_2
    const/4 v3, 0x0

    .line 774
    .local v3, "latest":Landroid/location/Location;
    const-string v4, "network"

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-eqz v0, :cond_3

    .line 775
    const/4 v7, 0x2

    :try_start_1
    new-array v7, v7, [Ljava/lang/String;

    const-string v8, "gps"

    aput-object v8, v7, v5

    aput-object v4, v7, v6

    goto :goto_0

    .line 776
    :cond_3
    new-array v7, v6, [Ljava/lang/String;

    aput-object v4, v7, v5

    :goto_0
    nop

    .line 777
    .local v7, "providers":[Ljava/lang/String;
    array-length v4, v7

    :goto_1
    if-ge v5, v4, :cond_7

    aget-object v6, v7, v5

    .line 778
    .local v6, "provider":Ljava/lang/String;
    invoke-virtual {v2}, Landroid/location/LocationManager;->getAllProviders()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8, v6}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_4

    goto :goto_2

    .line 779
    :cond_4
    invoke-virtual {v2, v6}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v8

    .line 780
    .local v8, "candidate":Landroid/location/Location;
    if-eqz v8, :cond_6

    if-eqz v3, :cond_5

    invoke-virtual {v8}, Landroid/location/Location;->getTime()J

    move-result-wide v9

    invoke-virtual {v3}, Landroid/location/Location;->getTime()J

    move-result-wide v11

    cmp-long v9, v9, v11

    if-lez v9, :cond_6

    .line 781
    :cond_5
    move-object v3, v8

    .line 777
    .end local v6    # "provider":Ljava/lang/String;
    .end local v8    # "candidate":Landroid/location/Location;
    :cond_6
    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 784
    :cond_7
    if-nez v3, :cond_8

    const-wide v4, 0x7fffffffffffffffL

    goto :goto_3

    :cond_8
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3}, Landroid/location/Location;->getTime()J

    move-result-wide v8

    sub-long/2addr v4, v8

    .line 785
    .local v4, "age":J
    :goto_3
    if-eqz v3, :cond_b

    const-wide/16 v8, 0x0

    cmp-long v6, v4, v8

    if-ltz v6, :cond_b

    const-wide/32 v8, 0x927c0

    cmp-long v6, v4, v8

    if-gtz v6, :cond_b

    .line 786
    invoke-virtual {v3}, Landroid/location/Location;->getLatitude()D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Double;->isFinite(D)Z

    move-result v6

    if-eqz v6, :cond_b

    invoke-virtual {v3}, Landroid/location/Location;->getLongitude()D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Double;->isFinite(D)Z

    move-result v6

    if-nez v6, :cond_9

    goto :goto_5

    .line 789
    :cond_9
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 790
    .local v6, "result":Lorg/json/JSONObject;
    const-string v8, "latitude"

    invoke-virtual {v3}, Landroid/location/Location;->getLatitude()D

    move-result-wide v9

    invoke-virtual {v6, v8, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 791
    const-string v8, "longitude"

    invoke-virtual {v3}, Landroid/location/Location;->getLongitude()D

    move-result-wide v9

    invoke-virtual {v6, v8, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    const-string v8, "timestamp"

    invoke-virtual {v3}, Landroid/location/Location;->getTime()J

    move-result-wide v9

    invoke-virtual {v6, v8, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v8, "accuracyMeters"

    invoke-virtual {v3}, Landroid/location/Location;->hasAccuracy()Z

    move-result v9

    if-eqz v9, :cond_a

    invoke-virtual {v3}, Landroid/location/Location;->getAccuracy()F

    move-result v9

    float-to-double v9, v9

    invoke-virtual {v6, v8, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_4

    :cond_a
    sget-object v9, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    invoke-virtual {v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 792
    :goto_4
    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    return-object v1

    .line 787
    .end local v6    # "result":Lorg/json/JSONObject;
    :cond_b
    :goto_5
    return-object v1

    .line 793
    .end local v3    # "latest":Landroid/location/Location;
    .end local v4    # "age":J
    .end local v7    # "providers":[Ljava/lang/String;
    :catch_0
    move-exception v3

    goto :goto_6

    :catch_1
    move-exception v3

    goto :goto_6

    :catch_2
    move-exception v3

    .line 794
    .local v3, "error":Ljava/lang/Exception;
    :goto_6
    const-string v4, "BLINK"

    const-string v5, "Could not read the current location for gym map centering."

    invoke-static {v4, v5, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 795
    return-object v1
.end method

.method hasBackgroundLocationPermission()Z
    .locals 2

    .line 703
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_1

    .line 704
    const-string v0, "android.permission.ACCESS_BACKGROUND_LOCATION"

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 703
    :goto_1
    return v0
.end method

.method hasNotificationPermission()Z
    .locals 2

    .line 668
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_1

    .line 669
    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 668
    :goto_1
    return v0
.end method

.method hasPreciseLocationPermission()Z
    .locals 1

    .line 699
    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method hasUsageAccess()Z
    .locals 1

    .line 834
    invoke-static {p0}, Lcom/blink/app/UsageSleepEstimator;->hasUsageAccess(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 7
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .line 263
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 264
    const/16 v0, 0x10

    const-string v1, "BLINK"

    const/4 v2, -0x1

    const/4 v3, 0x0

    if-ne p1, v0, :cond_8

    .line 265
    iget-object v0, p0, Lcom/blink/app/MainActivity;->pendingGoogleSignInRequest:Ljava/lang/String;

    .line 266
    .local v0, "requestId":Ljava/lang/String;
    iput-object v3, p0, Lcom/blink/app/MainActivity;->pendingGoogleSignInRequest:Ljava/lang/String;

    .line 267
    if-nez v0, :cond_0

    return-void

    .line 268
    :cond_0
    if-nez p3, :cond_1

    goto/16 :goto_3

    .line 273
    :cond_1
    :try_start_0
    invoke-static {p3}, Lcom/google/android/gms/auth/api/signin/GoogleSignIn;->getSignedInAccountFromIntent(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    const-class v4, Lcom/google/android/gms/common/api/ApiException;

    .line 274
    invoke-virtual {v2, v4}, Lcom/google/android/gms/tasks/Task;->getResult(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    .line 275
    .local v2, "account":Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
    if-nez v2, :cond_2

    move-object v4, v3

    goto :goto_0

    :cond_2
    invoke-virtual {v2}, Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;->getIdToken()Ljava/lang/String;

    move-result-object v4

    .line 276
    .local v4, "idToken":Ljava/lang/String;
    :goto_0
    if-eqz v4, :cond_4

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_3

    goto :goto_1

    .line 281
    :cond_3
    invoke-direct {p0, v0, v4, v3}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 288
    .end local v2    # "account":Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
    .end local v4    # "idToken":Ljava/lang/String;
    goto :goto_2

    .line 277
    .restart local v2    # "account":Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
    .restart local v4    # "idToken":Ljava/lang/String;
    :cond_4
    :goto_1
    const-string v5, "Google sign-in returned no ID token. Verify the Android OAuth client and Web client ID."

    invoke-direct {p0, v0, v3, v5}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lcom/google/android/gms/common/api/ApiException; {:try_start_0 .. :try_end_0} :catch_0

    .line 279
    return-void

    .line 282
    .end local v2    # "account":Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
    .end local v4    # "idToken":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 283
    .local v2, "error":Lcom/google/android/gms/common/api/ApiException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Native Google sign-in failed with status "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 284
    invoke-virtual {v2}, Lcom/google/android/gms/common/api/ApiException;->getStatusCode()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 283
    invoke-static {v1, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-virtual {v2}, Lcom/google/android/gms/common/api/ApiException;->getStatusCode()I

    move-result v4

    const/16 v5, 0x30d5

    if-ne v4, v5, :cond_5

    const-string v1, "Google sign-in canceled."

    invoke-direct {p0, v0, v3, v1}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_5
    const/4 v5, 0x7

    if-ne v4, v5, :cond_6

    const-string v1, "Check your internet connection."

    invoke-direct {p0, v0, v3, v1}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 285
    :cond_6
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Google sign-in failed (status "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 286
    invoke-virtual {v2}, Lcom/google/android/gms/common/api/ApiException;->getStatusCode()I

    move-result v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "): "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 287
    invoke-virtual {v2}, Lcom/google/android/gms/common/api/ApiException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 285
    invoke-direct {p0, v0, v3, v1}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 289
    .end local v2    # "error":Lcom/google/android/gms/common/api/ApiException;
    :goto_2
    return-void

    .line 269
    :goto_3
    if-nez p2, :cond_7

    const-string v1, "Google sign-in was canceled."

    invoke-direct {p0, v0, v3, v1}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 270
    return-void

    :cond_7
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Google sign-in returned no result (Android result code "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v3, v1}, Lcom/blink/app/MainActivity;->deliverGoogleSignInResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 291
    .end local v0    # "requestId":Ljava/lang/String;
    :cond_8
    const/16 v0, 0xe

    const/4 v4, 0x1

    const/4 v5, 0x0

    if-ne p1, v0, :cond_f

    .line 292
    if-ne p2, v2, :cond_9

    if-eqz p3, :cond_9

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    goto :goto_4

    :cond_9
    move-object v0, v3

    .line 293
    .local v0, "selected":Landroid/net/Uri;
    :goto_4
    iget-object v1, p0, Lcom/blink/app/MainActivity;->pendingFileChooser:Landroid/webkit/ValueCallback;

    .line 294
    .local v1, "callback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<[Landroid/net/Uri;>;"
    iput-object v3, p0, Lcom/blink/app/MainActivity;->pendingFileChooser:Landroid/webkit/ValueCallback;

    .line 295
    iget-boolean v2, p0, Lcom/blink/app/MainActivity;->pendingScheduleOcr:Z

    .line 296
    .local v2, "runOcr":Z
    iput-boolean v5, p0, Lcom/blink/app/MainActivity;->pendingScheduleOcr:Z

    .line 297
    if-eqz v2, :cond_c

    .line 298
    if-eqz v1, :cond_a

    invoke-interface {v1, v3}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 299
    :cond_a
    if-eqz v0, :cond_b

    invoke-direct {p0, v0}, Lcom/blink/app/MainActivity;->extractScheduleText(Landroid/net/Uri;)V

    .line 300
    :cond_b
    return-void

    .line 302
    :cond_c
    if-eqz v1, :cond_e

    if-nez v0, :cond_d

    goto :goto_5

    :cond_d
    new-array v3, v4, [Landroid/net/Uri;

    aput-object v0, v3, v5

    :goto_5
    invoke-interface {v1, v3}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 303
    :cond_e
    return-void

    .line 305
    .end local v0    # "selected":Landroid/net/Uri;
    .end local v1    # "callback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<[Landroid/net/Uri;>;"
    .end local v2    # "runOcr":Z
    :cond_f
    const/16 v0, 0xf

    if-ne p1, v0, :cond_16

    .line 306
    iget-object v0, p0, Lcom/blink/app/MainActivity;->pendingScheduleBackup:Ljava/lang/String;

    .line 307
    .local v0, "contents":Ljava/lang/String;
    iput-object v3, p0, Lcom/blink/app/MainActivity;->pendingScheduleBackup:Ljava/lang/String;

    .line 308
    if-ne p2, v2, :cond_15

    if-eqz p3, :cond_15

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v2

    if-nez v2, :cond_10

    goto :goto_8

    .line 312
    :cond_10
    :try_start_1
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 313
    .local v2, "output":Ljava/io/OutputStream;
    if-eqz v2, :cond_13

    .line 314
    if-nez v0, :cond_11

    :try_start_2
    const-string v3, ""

    goto :goto_6

    :cond_11
    move-object v3, v0

    :goto_6
    sget-object v6, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v3, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    .line 315
    const-string v3, "Schedule backup saved."

    invoke-direct {p0, v4, v3}, Lcom/blink/app/MainActivity;->notifyScheduleBackup(ZLjava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 316
    if-eqz v2, :cond_12

    :try_start_3
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    .line 319
    .end local v2    # "output":Ljava/io/OutputStream;
    :cond_12
    goto :goto_9

    .line 313
    .restart local v2    # "output":Ljava/io/OutputStream;
    :cond_13
    :try_start_4
    new-instance v3, Ljava/io/IOException;

    const-string v4, "Could not open the selected backup destination."

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "contents":Ljava/lang/String;
    .end local v2    # "output":Ljava/io/OutputStream;
    .end local p1    # "requestCode":I
    .end local p2    # "resultCode":I
    .end local p3    # "data":Landroid/content/Intent;
    throw v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 312
    .restart local v0    # "contents":Ljava/lang/String;
    .restart local v2    # "output":Ljava/io/OutputStream;
    .restart local p1    # "requestCode":I
    .restart local p2    # "resultCode":I
    .restart local p3    # "data":Landroid/content/Intent;
    :catchall_0
    move-exception v3

    if-eqz v2, :cond_14

    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_7

    :catchall_1
    move-exception v4

    :try_start_6
    invoke-virtual {v3, v4}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "contents":Ljava/lang/String;
    .end local p1    # "requestCode":I
    .end local p2    # "resultCode":I
    .end local p3    # "data":Landroid/content/Intent;
    :cond_14
    :goto_7
    throw v3
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    .line 316
    .end local v2    # "output":Ljava/io/OutputStream;
    .restart local v0    # "contents":Ljava/lang/String;
    .restart local p1    # "requestCode":I
    .restart local p2    # "resultCode":I
    .restart local p3    # "data":Landroid/content/Intent;
    :catch_1
    move-exception v2

    .line 317
    .local v2, "error":Ljava/lang/Exception;
    const-string v3, "Could not write the schedule backup."

    invoke-static {v1, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 318
    const-string v1, "Could not save the schedule backup."

    invoke-direct {p0, v5, v1}, Lcom/blink/app/MainActivity;->notifyScheduleBackup(ZLjava/lang/String;)V

    goto :goto_9

    .line 309
    .end local v2    # "error":Ljava/lang/Exception;
    :cond_15
    :goto_8
    const-string v1, "Schedule backup was not saved."

    invoke-direct {p0, v5, v1}, Lcom/blink/app/MainActivity;->notifyScheduleBackup(ZLjava/lang/String;)V

    .line 310
    return-void

    .line 321
    .end local v0    # "contents":Ljava/lang/String;
    :cond_16
    :goto_9
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 9
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 86
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 87
    invoke-static {p0}, Lcom/blink/app/MainActivityReference;->set(Lcom/blink/app/MainActivity;)V

    .line 88
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 89
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->setDecorFitsSystemWindows(Z)V

    goto :goto_0

    .line 91
    :cond_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x700

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 96
    :goto_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, 0x5

    const/4 v3, 0x6

    const/4 v4, 0x7

    invoke-static {v1, v3, v4}, Landroid/graphics/Color;->rgb(III)I

    move-result v5

    invoke-virtual {v0, v5}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 97
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-static {v1, v3, v4}, Landroid/graphics/Color;->rgb(III)I

    move-result v5

    invoke-virtual {v0, v5}, Landroid/view/Window;->setNavigationBarColor(I)V

    .line 98
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->createNotificationChannel()V

    .line 99
    invoke-static {p0}, Lcom/google/android/gms/location/LocationServices;->getGeofencingClient(Landroid/app/Activity;)Lcom/google/android/gms/location/GeofencingClient;

    move-result-object v0

    iput-object v0, p0, Lcom/blink/app/MainActivity;->geofencingClient:Lcom/google/android/gms/location/GeofencingClient;

    .line 100
    new-instance v0, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    sget-object v5, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;->DEFAULT_SIGN_IN:Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;

    invoke-direct {v0, v5}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;-><init>(Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;)V

    .line 102
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->requestEmail()Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    move-result-object v0

    sget v5, Lcom/blink/app/R$string;->default_web_client_id:I

    .line 103
    invoke-virtual {p0, v5}, Lcom/blink/app/MainActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->requestIdToken(Ljava/lang/String;)Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    move-result-object v0

    .line 104
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->build()Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;

    move-result-object v0

    .line 105
    .local v0, "googleSignInOptions":Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;
    invoke-static {p0, v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignIn;->getClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;)Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    move-result-object v5

    iput-object v5, p0, Lcom/blink/app/MainActivity;->googleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    .line 106
    new-instance v5, Landroidx/webkit/WebViewAssetLoader$Builder;

    invoke-direct {v5}, Landroidx/webkit/WebViewAssetLoader$Builder;-><init>()V

    new-instance v6, Landroidx/webkit/WebViewAssetLoader$AssetsPathHandler;

    invoke-direct {v6, p0}, Landroidx/webkit/WebViewAssetLoader$AssetsPathHandler;-><init>(Landroid/content/Context;)V

    .line 107
    const-string v7, "/assets/"

    invoke-virtual {v5, v7, v6}, Landroidx/webkit/WebViewAssetLoader$Builder;->addPathHandler(Ljava/lang/String;Landroidx/webkit/WebViewAssetLoader$PathHandler;)Landroidx/webkit/WebViewAssetLoader$Builder;

    move-result-object v5

    .line 108
    invoke-virtual {v5}, Landroidx/webkit/WebViewAssetLoader$Builder;->build()Landroidx/webkit/WebViewAssetLoader;

    move-result-object v5

    iput-object v5, p0, Lcom/blink/app/MainActivity;->assetLoader:Landroidx/webkit/WebViewAssetLoader;

    .line 110
    new-instance v5, Landroid/webkit/WebView;

    invoke-direct {v5, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v5, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    .line 111
    iget-object v5, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-static {v1, v3, v4}, Landroid/graphics/Color;->rgb(III)I

    move-result v6

    invoke-virtual {v5, v6}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 112
    iget-object v5, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v6, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda9;

    invoke-direct {v6}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda9;-><init>()V

    invoke-virtual {v5, v6}, Landroid/webkit/WebView;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 117
    iget-object v5, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v5}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v5

    .line 118
    .local v5, "settings":Landroid/webkit/WebSettings;
    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 119
    invoke-virtual {v5, v6}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 120
    invoke-virtual {v5, v6}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 121
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 122
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    .line 123
    invoke-virtual {v5, v2}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 124
    invoke-virtual {v5, v6}, Landroid/webkit/WebSettings;->setSupportMultipleWindows(Z)V

    .line 125
    invoke-virtual {v5, v6}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V

    .line 126
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v2

    .line 127
    .local v2, "cookies":Landroid/webkit/CookieManager;
    invoke-virtual {v2, v6}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V

    .line 128
    iget-object v7, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v2, v7, v6}, Landroid/webkit/CookieManager;->setAcceptThirdPartyCookies(Landroid/webkit/WebView;Z)V

    .line 129
    iget-object v6, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v7, Lcom/blink/app/TrackingBridge;

    invoke-direct {v7, p0}, Lcom/blink/app/TrackingBridge;-><init>(Lcom/blink/app/MainActivity;)V

    const-string v8, "BlinkNative"

    invoke-virtual {v6, v7, v8}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 130
    iget-object v6, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v7, Lcom/blink/app/MainActivity$1;

    invoke-direct {v7, p0}, Lcom/blink/app/MainActivity$1;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v6, v7}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 142
    iget-object v6, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v7, Lcom/blink/app/MainActivity$2;

    invoke-direct {v7, p0}, Lcom/blink/app/MainActivity$2;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v6, v7}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 211
    new-instance v6, Landroid/widget/FrameLayout;

    invoke-direct {v6, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 212
    .local v6, "content":Landroid/widget/FrameLayout;
    invoke-static {v1, v3, v4}, Landroid/graphics/Color;->rgb(III)I

    move-result v1

    invoke-virtual {v6, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    .line 213
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v1, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 215
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->createSplashOverlay()Landroid/widget/FrameLayout;

    move-result-object v1

    iput-object v1, p0, Lcom/blink/app/MainActivity;->splashOverlay:Landroid/widget/FrameLayout;

    .line 216
    iget-object v1, p0, Lcom/blink/app/MainActivity;->splashOverlay:Landroid/widget/FrameLayout;

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v1, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 218
    invoke-virtual {p0, v6}, Lcom/blink/app/MainActivity;->setContentView(Landroid/view/View;)V

    .line 219
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->requestApplyInsets()V

    .line 220
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->startSplashAnimation()V

    .line 221
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    const-string v3, "https://appassets.androidplatform.net/assets/www/index.html"

    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 222
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .line 567
    iget-object v0, p0, Lcom/blink/app/MainActivity;->scheduleOcrExecutor:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 568
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 569
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    const-string v1, "BlinkNative"

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 570
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    .line 571
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    .line 573
    :cond_0
    invoke-static {p0}, Lcom/blink/app/MainActivityReference;->clear(Lcom/blink/app/MainActivity;)V

    .line 574
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 575
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "permissions"    # [Ljava/lang/String;
    .param p3, "grantResults"    # [I

    .line 682
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    .line 683
    const/16 v0, 0xd

    if-ne p1, v0, :cond_0

    .line 684
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 685
    return-void

    .line 687
    :cond_0
    const/16 v0, 0xb

    const/16 v1, 0xa

    if-eq p1, v1, :cond_1

    if-eq p1, v0, :cond_1

    const/16 v2, 0xc

    if-ne p1, v2, :cond_4

    .line 688
    :cond_1
    if-ne p1, v0, :cond_2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    .line 689
    :cond_2
    if-ne p1, v1, :cond_3

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v0

    if-nez v0, :cond_3

    .line 690
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 691
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 692
    return-void

    .line 694
    :cond_3
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->continuePermissionFlow()V

    .line 696
    :cond_4
    return-void
.end method

.method protected onResume()V
    .locals 3

    .line 550
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 551
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 552
    .local v0, "store":Lcom/blink/app/TrackingStore;
    invoke-static {p0}, Lcom/blink/app/LocationSchedule;->apply(Landroid/content/Context;)V

    .line 555
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasBackgroundLocationPermission()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 556
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->registerGymGeofence()V

    .line 558
    :cond_0
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-eqz v1, :cond_1

    .line 559
    iget-object v1, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda17;

    invoke-direct {v2, p0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda17;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 563
    :cond_1
    return-void
.end method

.method openAppLocationSettings()V
    .locals 3

    .line 752
    new-instance v0, Landroid/content/Intent;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "package:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 753
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const-string v2, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {v0, v2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 754
    .local v0, "intent":Landroid/content/Intent;
    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 755
    return-void
.end method

.method openUsageAccessSettings()V
    .locals 2

    .line 758
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.USAGE_ACCESS_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 759
    return-void
.end method

.method publishTrackingUpdate()V
    .locals 2

    .line 818
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    if-nez v0, :cond_0

    return-void

    .line 819
    :cond_0
    iget-object v0, p0, Lcom/blink/app/MainActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda13;

    invoke-direct {v1, p0}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda13;-><init>(Lcom/blink/app/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    .line 822
    return-void
.end method

.method refreshSleepEstimate()Ljava/lang/String;
    .locals 1

    .line 830
    new-instance v0, Lcom/blink/app/UsageSleepEstimator;

    invoke-direct {v0, p0}, Lcom/blink/app/UsageSleepEstimator;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/blink/app/UsageSleepEstimator;->refreshEstimate()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method requestClassReminderPermission()V
    .locals 6

    .line 658
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_2

    .line 659
    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 660
    :cond_0
    const-string v1, "blink_notification_permissions"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/blink/app/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 662
    .local v1, "preferences":Landroid/content/SharedPreferences;
    const-string v3, "class_reminder_permission_asked"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_1

    return-void

    .line 663
    :cond_1
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    const/4 v5, 0x1

    invoke-interface {v4, v3, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 664
    new-array v3, v5, [Ljava/lang/String;

    aput-object v0, v3, v2

    const/16 v0, 0xd

    invoke-virtual {p0, v3, v0}, Lcom/blink/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 665
    return-void

    .line 659
    .end local v1    # "preferences":Landroid/content/SharedPreferences;
    :cond_2
    :goto_0
    return-void
.end method

.method requestGoogleSignIn(Ljava/lang/String;)V
    .locals 2
    .param p1, "requestId"    # Ljava/lang/String;

    .line 324
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 328
    :cond_0
    new-instance v0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda11;

    invoke-direct {v0, p0, p1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda11;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 342
    return-void

    .line 325
    :cond_1
    :goto_0
    const-string v0, "BLINK"

    const-string v1, "Rejected Google sign-in request without an ID."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 326
    return-void
.end method

.method requestGymDetectionPermissions()V
    .locals 1

    .line 858
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 859
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    .line 860
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->continuePermissionFlow()V

    .line 861
    return-void
.end method

.method saveScheduleBackup(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "contents"    # Ljava/lang/String;

    .line 429
    new-instance v0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0, p2, p1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 444
    return-void
.end method

.method selectScheduleFile(Ljava/lang/String;)V
    .locals 1
    .param p1, "kind"    # Ljava/lang/String;

    .line 244
    new-instance v0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda6;

    invoke-direct {v0, p0, p1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda6;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 259
    return-void
.end method

.method setGymDetectionEnabled(Z)V
    .locals 2
    .param p1, "enabled"    # Z

    .line 885
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 886
    .local v0, "store":Lcom/blink/app/TrackingStore;
    invoke-virtual {v0, p1}, Lcom/blink/app/TrackingStore;->setGymDetectionEnabled(Z)V

    .line 887
    if-eqz p1, :cond_0

    .line 888
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 889
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    .line 890
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->continuePermissionFlow()V

    goto :goto_0

    .line 892
    :cond_0
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->removeGymGeofence()V

    .line 894
    :goto_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 895
    return-void
.end method

.method setGymLocation(DDF)V
    .locals 7
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D
    .param p5, "radiusMeters"    # F

    .line 838
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    move-object v1, v0

    .line 839
    .local v1, "store":Lcom/blink/app/TrackingStore;
    move-wide v2, p1

    move-wide v4, p3

    move v6, p5

    .end local p1    # "latitude":D
    .end local p3    # "longitude":D
    .end local p5    # "radiusMeters":F
    .local v2, "latitude":D
    .local v4, "longitude":D
    .local v6, "radiusMeters":F
    invoke-virtual/range {v1 .. v6}, Lcom/blink/app/TrackingStore;->setGymLocation(DDF)V

    .line 840
    invoke-virtual {v1}, Lcom/blink/app/TrackingStore;->isGymDetectionEnabled()Z

    move-result p1

    if-eqz p1, :cond_0

    .line 841
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 842
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    .line 843
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->continuePermissionFlow()V

    .line 845
    :cond_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 846
    return-void
.end method

.method showNotification(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    .line 800
    new-instance v0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda12;

    invoke-direct {v0, p0, p1, p2}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda12;-><init>(Lcom/blink/app/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/blink/app/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 815
    return-void
.end method

.method signOutGoogle()V
    .locals 2

    .line 345
    iget-object v0, p0, Lcom/blink/app/MainActivity;->googleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;->signOut()Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    new-instance v1, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1}, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda2;-><init>()V

    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;

    .line 347
    return-void
.end method

.method startCardio()V
    .locals 4

    .line 708
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v0

    if-nez v0, :cond_0

    .line 709
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->permissionFlowActive:Z

    .line 710
    iput-boolean v0, p0, Lcom/blink/app/MainActivity;->activityPermissionAskedThisFlow:Z

    .line 711
    new-instance v1, Lcom/blink/app/TrackingStore;

    invoke-direct {v1, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lcom/blink/app/TrackingStore;->setCardioStartRequested(Z)V

    .line 712
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "android.permission.ACCESS_COARSE_LOCATION"

    aput-object v3, v1, v2

    const-string v2, "android.permission.ACCESS_FINE_LOCATION"

    aput-object v2, v1, v0

    const/16 v0, 0xa

    invoke-virtual {p0, v1, v0}, Lcom/blink/app/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 714
    return-void

    .line 716
    :cond_0
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->startCardio()V

    .line 717
    invoke-direct {p0}, Lcom/blink/app/MainActivity;->startTrackingService()V

    .line 718
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 719
    return-void
.end method

.method stopCardio()V
    .locals 3

    .line 722
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->finishCardio()V

    .line 723
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    .line 724
    .local v0, "store":Lcom/blink/app/TrackingStore;
    invoke-virtual {v0}, Lcom/blink/app/TrackingStore;->isLocationTrackingEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/blink/app/LocationTrackingService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/blink/app/MainActivity;->stopService(Landroid/content/Intent;)Z

    .line 725
    :cond_0
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->publishTrackingUpdate()V

    .line 726
    return-void
.end method

.method trackingStateJson()Ljava/lang/String;
    .locals 4

    .line 825
    new-instance v0, Lcom/blink/app/TrackingStore;

    invoke-direct {v0, p0}, Lcom/blink/app/TrackingStore;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasPreciseLocationPermission()Z

    move-result v1

    .line 826
    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasBackgroundLocationPermission()Z

    move-result v2

    invoke-virtual {p0}, Lcom/blink/app/MainActivity;->hasUsageAccess()Z

    move-result v3

    .line 825
    invoke-virtual {v0, v1, v2, v3}, Lcom/blink/app/TrackingStore;->stateJson(ZZZ)Lorg/json/JSONObject;

    move-result-object v0

    .line 826
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    .line 825
    return-object v0
.end method
