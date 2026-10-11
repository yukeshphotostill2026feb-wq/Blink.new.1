.class Lcom/blink/app/LocationTrackingService$1;
.super Lcom/google/android/gms/location/LocationCallback;
.source "LocationTrackingService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blink/app/LocationTrackingService;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/blink/app/LocationTrackingService;


# direct methods
.method constructor <init>(Lcom/blink/app/LocationTrackingService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/blink/app/LocationTrackingService;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 50
    iput-object p1, p0, Lcom/blink/app/LocationTrackingService$1;->this$0:Lcom/blink/app/LocationTrackingService;

    invoke-direct {p0}, Lcom/google/android/gms/location/LocationCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onLocationResult(Lcom/google/android/gms/location/LocationResult;)V
    .locals 3
    .param p1, "result"    # Lcom/google/android/gms/location/LocationResult;

    .line 53
    invoke-virtual {p1}, Lcom/google/android/gms/location/LocationResult;->getLocations()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/location/Location;

    .local v1, "location":Landroid/location/Location;
    iget-object v2, p0, Lcom/blink/app/LocationTrackingService$1;->this$0:Lcom/blink/app/LocationTrackingService;

    invoke-static {v2, v1}, Lcom/blink/app/LocationTrackingService;->-$$Nest$mprocessLocation(Lcom/blink/app/LocationTrackingService;Landroid/location/Location;)V

    .end local v1    # "location":Landroid/location/Location;
    goto :goto_0

    .line 54
    :cond_0
    iget-object v0, p0, Lcom/blink/app/LocationTrackingService$1;->this$0:Lcom/blink/app/LocationTrackingService;

    invoke-static {v0}, Lcom/blink/app/LocationTrackingService;->-$$Nest$mupdateNotification(Lcom/blink/app/LocationTrackingService;)V

    .line 55
    return-void
.end method
