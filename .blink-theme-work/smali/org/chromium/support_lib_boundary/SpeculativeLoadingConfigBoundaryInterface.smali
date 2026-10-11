.class public interface abstract Lorg/chromium/support_lib_boundary/SpeculativeLoadingConfigBoundaryInterface;
.super Ljava/lang/Object;
.source "SpeculativeLoadingConfigBoundaryInterface.java"


# annotations
.annotation runtime Lorg/jspecify/annotations/NullMarked;
.end annotation


# virtual methods
.method public abstract getMaxPrefetches()I
.end method

.method public getMaxPrerenders()I
    .locals 1

    .line 18
    const/4 v0, 0x0

    return v0
.end method

.method public abstract getPrefetchTTLSeconds()I
.end method
