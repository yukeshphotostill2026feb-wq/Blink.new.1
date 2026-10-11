.class final Lcom/blink/app/MainActivityReference;
.super Ljava/lang/Object;
.source "MainActivityReference.java"


# static fields
.field private static reference:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/blink/app/MainActivity;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 6
    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/blink/app/MainActivityReference;->reference:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static clear(Lcom/blink/app/MainActivity;)V
    .locals 1
    .param p0, "activity"    # Lcom/blink/app/MainActivity;

    .line 19
    sget-object v0, Lcom/blink/app/MainActivityReference;->reference:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p0, :cond_0

    sget-object v0, Lcom/blink/app/MainActivityReference;->reference:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    .line 20
    :cond_0
    return-void
.end method

.method static get()Lcom/blink/app/MainActivity;
    .locals 1

    .line 15
    sget-object v0, Lcom/blink/app/MainActivityReference;->reference:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/blink/app/MainActivity;

    return-object v0
.end method

.method static set(Lcom/blink/app/MainActivity;)V
    .locals 1
    .param p0, "activity"    # Lcom/blink/app/MainActivity;

    .line 11
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/blink/app/MainActivityReference;->reference:Ljava/lang/ref/WeakReference;

    .line 12
    return-void
.end method
