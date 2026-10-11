.class public Landroidx/webkit/SpeculativeLoadingConfig;
.super Ljava/lang/Object;
.source "SpeculativeLoadingConfig.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/webkit/SpeculativeLoadingConfig$Builder;
    }
.end annotation


# static fields
.field public static final ABSOLUTE_MAX_PREFETCHES:I = 0x14

.field public static final DEFAULT_MAX_PREFETCHES:I = 0xa

.field public static final DEFAULT_TTL_SECS:I = 0x3c


# instance fields
.field private final mMaxPrefetches:I

.field private final mPrefetchTTLSeconds:I


# direct methods
.method private constructor <init>(II)V
    .locals 0
    .param p1, "ttlSecs"    # I
    .param p2, "max"    # I

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    iput p1, p0, Landroidx/webkit/SpeculativeLoadingConfig;->mPrefetchTTLSeconds:I

    .line 56
    iput p2, p0, Landroidx/webkit/SpeculativeLoadingConfig;->mMaxPrefetches:I

    .line 57
    return-void
.end method

.method synthetic constructor <init>(IILandroidx/webkit/SpeculativeLoadingConfig$1;)V
    .locals 0
    .param p1, "x0"    # I
    .param p2, "x1"    # I
    .param p3, "x2"    # Landroidx/webkit/SpeculativeLoadingConfig$1;

    .line 28
    invoke-direct {p0, p1, p2}, Landroidx/webkit/SpeculativeLoadingConfig;-><init>(II)V

    return-void
.end method


# virtual methods
.method public getMaxPrefetches()I
    .locals 1

    .line 78
    iget v0, p0, Landroidx/webkit/SpeculativeLoadingConfig;->mMaxPrefetches:I

    return v0
.end method

.method public getPrefetchTtlSeconds()I
    .locals 1

    .line 67
    iget v0, p0, Landroidx/webkit/SpeculativeLoadingConfig;->mPrefetchTTLSeconds:I

    return v0
.end method
