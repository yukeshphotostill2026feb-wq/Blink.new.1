.class public final synthetic Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/blink/app/MainActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/blink/app/MainActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda5;->f$0:Lcom/blink/app/MainActivity;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/blink/app/TrackingBridge$$ExternalSyntheticLambda5;->f$0:Lcom/blink/app/MainActivity;

    invoke-virtual {v0}, Lcom/blink/app/MainActivity;->stopCardio()V

    return-void
.end method
