.class final Lcom/blink/app/TrackingStore$LocationServicesProvider;
.super Ljava/lang/Object;
.source "TrackingStore.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blink/app/TrackingStore;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LocationServicesProvider"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 481
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static client(Landroid/content/Context;)Lcom/google/android/gms/location/GeofencingClient;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 483
    invoke-static {p0}, Lcom/google/android/gms/location/LocationServices;->getGeofencingClient(Landroid/content/Context;)Lcom/google/android/gms/location/GeofencingClient;

    move-result-object v0

    return-object v0
.end method
