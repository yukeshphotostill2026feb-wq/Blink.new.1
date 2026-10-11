.class public Landroidx/webkit/internal/PrefetchOperationCallbackAdapter;
.super Ljava/lang/Object;
.source "PrefetchOperationCallbackAdapter.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/PrefetchNetworkException;
    .locals 1
    .param p0, "x0"    # Ljava/lang/reflect/InvocationHandler;

    .line 32
    invoke-static {p0}, Landroidx/webkit/internal/PrefetchOperationCallbackAdapter;->getNetworkException(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/PrefetchNetworkException;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$100(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/PrefetchException;
    .locals 1
    .param p0, "x0"    # Ljava/lang/reflect/InvocationHandler;

    .line 32
    invoke-static {p0}, Landroidx/webkit/internal/PrefetchOperationCallbackAdapter;->getPrefetchException(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/PrefetchException;

    move-result-object v0

    return-object v0
.end method

.method public static buildInvocationHandler(Landroidx/webkit/OutcomeReceiverCompat;)Ljava/lang/reflect/InvocationHandler;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/webkit/OutcomeReceiverCompat<",
            "Ljava/lang/Void;",
            "Landroidx/webkit/PrefetchException;",
            ">;)",
            "Ljava/lang/reflect/InvocationHandler;"
        }
    .end annotation

    .line 42
    .local p0, "callback":Landroidx/webkit/OutcomeReceiverCompat;, "Landroidx/webkit/OutcomeReceiverCompat<Ljava/lang/Void;Landroidx/webkit/PrefetchException;>;"
    new-instance v0, Landroidx/webkit/internal/PrefetchOperationCallbackAdapter$1;

    invoke-direct {v0, p0}, Landroidx/webkit/internal/PrefetchOperationCallbackAdapter$1;-><init>(Landroidx/webkit/OutcomeReceiverCompat;)V

    .line 60
    .local v0, "operationCallback":Lorg/chromium/support_lib_boundary/PrefetchOperationCallbackBoundaryInterface;
    invoke-static {v0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    return-object v1
.end method

.method private static getNetworkException(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/PrefetchNetworkException;
    .locals 4
    .param p0, "error"    # Ljava/lang/reflect/InvocationHandler;

    .line 65
    const-class v0, Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;

    .line 66
    invoke-static {v0, p0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;

    .line 68
    .local v0, "failure":Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;
    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;->getMessage()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 69
    new-instance v1, Landroidx/webkit/PrefetchNetworkException;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;->getMessage()Ljava/lang/String;

    move-result-object v2

    .line 70
    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;->getHttpResponseStatusCode()I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroidx/webkit/PrefetchNetworkException;-><init>(Ljava/lang/String;I)V

    .line 69
    return-object v1

    .line 72
    :cond_0
    new-instance v1, Landroidx/webkit/PrefetchNetworkException;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/PrefetchNetworkExceptionBoundaryInterface;->getHttpResponseStatusCode()I

    move-result v2

    invoke-direct {v1, v2}, Landroidx/webkit/PrefetchNetworkException;-><init>(I)V

    return-object v1
.end method

.method private static getPrefetchException(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/PrefetchException;
    .locals 3
    .param p0, "error"    # Ljava/lang/reflect/InvocationHandler;

    .line 77
    const-class v0, Lorg/chromium/support_lib_boundary/PrefetchExceptionBoundaryInterface;

    .line 78
    invoke-static {v0, p0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/chromium/support_lib_boundary/PrefetchExceptionBoundaryInterface;

    .line 80
    .local v0, "failure":Lorg/chromium/support_lib_boundary/PrefetchExceptionBoundaryInterface;
    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/PrefetchExceptionBoundaryInterface;->getMessage()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 81
    new-instance v1, Landroidx/webkit/PrefetchException;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/PrefetchExceptionBoundaryInterface;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Landroidx/webkit/PrefetchException;-><init>(Ljava/lang/String;)V

    return-object v1

    .line 83
    :cond_0
    new-instance v1, Landroidx/webkit/PrefetchException;

    invoke-direct {v1}, Landroidx/webkit/PrefetchException;-><init>()V

    return-object v1
.end method
