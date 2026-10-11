.class public Landroidx/webkit/internal/WebViewProviderAdapter;
.super Ljava/lang/Object;
.source "WebViewProviderAdapter.java"


# instance fields
.field final mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;


# direct methods
.method public constructor <init>(Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;)V
    .locals 0
    .param p1, "impl"    # Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    iput-object p1, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    .line 57
    return-void
.end method

.method static synthetic lambda$prerenderUrlAsync$0(Landroidx/webkit/PrerenderOperationCallback;Ljava/lang/Void;)V
    .locals 0
    .param p0, "callback"    # Landroidx/webkit/PrerenderOperationCallback;
    .param p1, "value"    # Ljava/lang/Void;

    .line 210
    invoke-interface {p0}, Landroidx/webkit/PrerenderOperationCallback;->onPrerenderActivated()V

    .line 211
    return-void
.end method

.method static synthetic lambda$prerenderUrlAsync$1(Landroidx/webkit/PrerenderOperationCallback;Ljava/lang/Throwable;)V
    .locals 2
    .param p0, "callback"    # Landroidx/webkit/PrerenderOperationCallback;
    .param p1, "throwable"    # Ljava/lang/Throwable;

    .line 213
    new-instance v0, Landroidx/webkit/PrerenderException;

    const-string v1, "Prerender operation failed"

    invoke-direct {v0, v1, p1}, Landroidx/webkit/PrerenderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {p0, v0}, Landroidx/webkit/PrerenderOperationCallback;->onError(Landroidx/webkit/PrerenderException;)V

    .line 214
    return-void
.end method

.method static synthetic lambda$prerenderUrlAsync$2(Landroidx/webkit/PrerenderOperationCallback;Ljava/lang/Void;)V
    .locals 0
    .param p0, "callback"    # Landroidx/webkit/PrerenderOperationCallback;
    .param p1, "value"    # Ljava/lang/Void;

    .line 240
    invoke-interface {p0}, Landroidx/webkit/PrerenderOperationCallback;->onPrerenderActivated()V

    .line 241
    return-void
.end method

.method static synthetic lambda$prerenderUrlAsync$3(Landroidx/webkit/PrerenderOperationCallback;Ljava/lang/Throwable;)V
    .locals 2
    .param p0, "callback"    # Landroidx/webkit/PrerenderOperationCallback;
    .param p1, "throwable"    # Ljava/lang/Throwable;

    .line 243
    new-instance v0, Landroidx/webkit/PrerenderException;

    const-string v1, "Prerender operation failed"

    invoke-direct {v0, v1, p1}, Landroidx/webkit/PrerenderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {p0, v0}, Landroidx/webkit/PrerenderOperationCallback;->onError(Landroidx/webkit/PrerenderException;)V

    .line 244
    return-void
.end method


# virtual methods
.method public addDocumentStartJavaScript(Ljava/lang/String;[Ljava/lang/String;)Landroidx/webkit/internal/ScriptHandlerImpl;
    .locals 1
    .param p1, "script"    # Ljava/lang/String;
    .param p2, "allowedOriginRules"    # [Ljava/lang/String;

    .line 108
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    .line 109
    invoke-interface {v0, p1, p2}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->addDocumentStartJavaScript(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    .line 108
    invoke-static {v0}, Landroidx/webkit/internal/ScriptHandlerImpl;->toScriptHandler(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/internal/ScriptHandlerImpl;

    move-result-object v0

    return-object v0
.end method

.method public addWebMessageListener(Ljava/lang/String;[Ljava/lang/String;Landroidx/webkit/WebViewCompat$WebMessageListener;)V
    .locals 2
    .param p1, "jsObjectName"    # Ljava/lang/String;
    .param p2, "allowedOriginRules"    # [Ljava/lang/String;
    .param p3, "listener"    # Landroidx/webkit/WebViewCompat$WebMessageListener;

    .line 97
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    new-instance v1, Landroidx/webkit/internal/WebMessageListenerAdapter;

    invoke-direct {v1, p3}, Landroidx/webkit/internal/WebMessageListenerAdapter;-><init>(Landroidx/webkit/WebViewCompat$WebMessageListener;)V

    .line 98
    invoke-static {v1}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    .line 97
    invoke-interface {v0, p1, p2, v1}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->addWebMessageListener(Ljava/lang/String;[Ljava/lang/String;Ljava/lang/reflect/InvocationHandler;)V

    .line 100
    return-void
.end method

.method public createWebMessageChannel()[Landroidx/webkit/WebMessagePortCompat;
    .locals 5

    .line 73
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->createWebMessageChannel()[Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    .line 74
    .local v0, "invocationHandlers":[Ljava/lang/reflect/InvocationHandler;
    array-length v1, v0

    new-array v1, v1, [Landroidx/webkit/WebMessagePortCompat;

    .line 75
    .local v1, "messagePorts":[Landroidx/webkit/WebMessagePortCompat;
    const/4 v2, 0x0

    .local v2, "n":I
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_0

    .line 76
    new-instance v3, Landroidx/webkit/internal/WebMessagePortImpl;

    aget-object v4, v0, v2

    invoke-direct {v3, v4}, Landroidx/webkit/internal/WebMessagePortImpl;-><init>(Ljava/lang/reflect/InvocationHandler;)V

    aput-object v3, v1, v2

    .line 75
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 78
    .end local v2    # "n":I
    :cond_0
    return-object v1
.end method

.method public getProfile()Landroidx/webkit/Profile;
    .locals 2

    .line 177
    const-class v0, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    iget-object v1, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    .line 178
    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->getProfile()Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    .line 177
    invoke-static {v0, v1}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;

    .line 180
    .local v0, "profile":Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;
    new-instance v1, Landroidx/webkit/internal/ProfileImpl;

    invoke-direct {v1, v0}, Landroidx/webkit/internal/ProfileImpl;-><init>(Lorg/chromium/support_lib_boundary/ProfileBoundaryInterface;)V

    return-object v1
.end method

.method public getWebChromeClient()Landroid/webkit/WebChromeClient;
    .locals 1

    .line 130
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->getWebChromeClient()Landroid/webkit/WebChromeClient;

    move-result-object v0

    return-object v0
.end method

.method public getWebViewClient()Landroid/webkit/WebViewClient;
    .locals 1

    .line 123
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->getWebViewClient()Landroid/webkit/WebViewClient;

    move-result-object v0

    return-object v0
.end method

.method public getWebViewRenderProcess()Landroidx/webkit/WebViewRenderProcess;
    .locals 1

    .line 137
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->getWebViewRenderer()Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    invoke-static {v0}, Landroidx/webkit/internal/WebViewRenderProcessImpl;->forInvocationHandler(Ljava/lang/reflect/InvocationHandler;)Landroidx/webkit/internal/WebViewRenderProcessImpl;

    move-result-object v0

    return-object v0
.end method

.method public getWebViewRenderProcessClient()Landroidx/webkit/WebViewRenderProcessClient;
    .locals 2

    .line 144
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->getWebViewRendererClient()Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    .line 145
    .local v0, "handler":Ljava/lang/reflect/InvocationHandler;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 146
    :cond_0
    nop

    .line 147
    invoke-static {v0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->getDelegateFromInvocationHandler(Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/webkit/internal/WebViewRenderProcessClientAdapter;

    .line 148
    invoke-virtual {v1}, Landroidx/webkit/internal/WebViewRenderProcessClientAdapter;->getWebViewRenderProcessClient()Landroidx/webkit/WebViewRenderProcessClient;

    move-result-object v1

    .line 146
    return-object v1
.end method

.method public insertVisualStateCallback(JLandroidx/webkit/WebViewCompat$VisualStateCallback;)V
    .locals 2
    .param p1, "requestId"    # J
    .param p3, "callback"    # Landroidx/webkit/WebViewCompat$VisualStateCallback;

    .line 64
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    new-instance v1, Landroidx/webkit/internal/VisualStateCallbackAdapter;

    invoke-direct {v1, p3}, Landroidx/webkit/internal/VisualStateCallbackAdapter;-><init>(Landroidx/webkit/WebViewCompat$VisualStateCallback;)V

    .line 65
    invoke-static {v1}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    .line 64
    invoke-interface {v0, p1, p2, v1}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->insertVisualStateCallback(JLjava/lang/reflect/InvocationHandler;)V

    .line 67
    return-void
.end method

.method public isAudioMuted()Z
    .locals 1

    .line 187
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->isAudioMuted()Z

    move-result v0

    return v0
.end method

.method public postWebMessage(Landroidx/webkit/WebMessageCompat;Landroid/net/Uri;)V
    .locals 2
    .param p1, "message"    # Landroidx/webkit/WebMessageCompat;
    .param p2, "targetOrigin"    # Landroid/net/Uri;

    .line 85
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    new-instance v1, Landroidx/webkit/internal/WebMessageAdapter;

    invoke-direct {v1, p1}, Landroidx/webkit/internal/WebMessageAdapter;-><init>(Landroidx/webkit/WebMessageCompat;)V

    .line 86
    invoke-static {v1}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    .line 85
    invoke-interface {v0, v1, p2}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->postMessageToMainFrame(Ljava/lang/reflect/InvocationHandler;Landroid/net/Uri;)V

    .line 88
    return-void
.end method

.method public prerenderUrlAsync(Ljava/lang/String;Landroid/os/CancellationSignal;Ljava/util/concurrent/Executor;Landroidx/webkit/PrerenderOperationCallback;)V
    .locals 7
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p3, "callbackExecutor"    # Ljava/util/concurrent/Executor;
    .param p4, "callback"    # Landroidx/webkit/PrerenderOperationCallback;

    .line 208
    new-instance v0, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda2;

    invoke-direct {v0, p4}, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda2;-><init>(Landroidx/webkit/PrerenderOperationCallback;)V

    move-object v5, v0

    .line 212
    .local v5, "activationCallback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Void;>;"
    new-instance v6, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda3;

    invoke-direct {v6, p4}, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda3;-><init>(Landroidx/webkit/PrerenderOperationCallback;)V

    .line 215
    .local v6, "errorCallback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Throwable;>;"
    iget-object v1, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    .end local p1    # "url":Ljava/lang/String;
    .end local p2    # "cancellationSignal":Landroid/os/CancellationSignal;
    .end local p3    # "callbackExecutor":Ljava/util/concurrent/Executor;
    .local v2, "url":Ljava/lang/String;
    .local v3, "cancellationSignal":Landroid/os/CancellationSignal;
    .local v4, "callbackExecutor":Ljava/util/concurrent/Executor;
    invoke-interface/range {v1 .. v6}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->prerenderUrl(Ljava/lang/String;Landroid/os/CancellationSignal;Ljava/util/concurrent/Executor;Landroid/webkit/ValueCallback;Landroid/webkit/ValueCallback;)V

    .line 221
    return-void
.end method

.method public prerenderUrlAsync(Ljava/lang/String;Landroid/os/CancellationSignal;Ljava/util/concurrent/Executor;Landroidx/webkit/SpeculativeLoadingParameters;Landroidx/webkit/PrerenderOperationCallback;)V
    .locals 8
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p3, "callbackExecutor"    # Ljava/util/concurrent/Executor;
    .param p4, "params"    # Landroidx/webkit/SpeculativeLoadingParameters;
    .param p5, "callback"    # Landroidx/webkit/PrerenderOperationCallback;

    .line 235
    new-instance v0, Landroidx/webkit/internal/SpeculativeLoadingParametersAdapter;

    invoke-direct {v0, p4}, Landroidx/webkit/internal/SpeculativeLoadingParametersAdapter;-><init>(Landroidx/webkit/SpeculativeLoadingParameters;)V

    .line 236
    invoke-static {v0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v5

    .line 238
    .local v5, "paramsBoundaryInterface":Ljava/lang/reflect/InvocationHandler;
    new-instance v6, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda0;

    invoke-direct {v6, p5}, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda0;-><init>(Landroidx/webkit/PrerenderOperationCallback;)V

    .line 242
    .local v6, "activationCallback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Void;>;"
    new-instance v7, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda1;

    invoke-direct {v7, p5}, Landroidx/webkit/internal/WebViewProviderAdapter$$ExternalSyntheticLambda1;-><init>(Landroidx/webkit/PrerenderOperationCallback;)V

    .line 245
    .local v7, "errorCallback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/Throwable;>;"
    iget-object v1, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    .end local p1    # "url":Ljava/lang/String;
    .end local p2    # "cancellationSignal":Landroid/os/CancellationSignal;
    .end local p3    # "callbackExecutor":Ljava/util/concurrent/Executor;
    .local v2, "url":Ljava/lang/String;
    .local v3, "cancellationSignal":Landroid/os/CancellationSignal;
    .local v4, "callbackExecutor":Ljava/util/concurrent/Executor;
    invoke-interface/range {v1 .. v7}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->prerenderUrl(Ljava/lang/String;Landroid/os/CancellationSignal;Ljava/util/concurrent/Executor;Ljava/lang/reflect/InvocationHandler;Landroid/webkit/ValueCallback;Landroid/webkit/ValueCallback;)V

    .line 252
    return-void
.end method

.method public removeWebMessageListener(Ljava/lang/String;)V
    .locals 1
    .param p1, "jsObjectName"    # Ljava/lang/String;

    .line 116
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0, p1}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->removeWebMessageListener(Ljava/lang/String;)V

    .line 117
    return-void
.end method

.method public setAudioMuted(Z)V
    .locals 1
    .param p1, "mute"    # Z

    .line 194
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0, p1}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->setAudioMuted(Z)V

    .line 195
    return-void
.end method

.method public setProfileWithName(Ljava/lang/String;)V
    .locals 1
    .param p1, "profileName"    # Ljava/lang/String;

    .line 170
    iget-object v0, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v0, p1}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->setProfile(Ljava/lang/String;)V

    .line 171
    return-void
.end method

.method public setWebViewRenderProcessClient(Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V
    .locals 2
    .param p1, "executor"    # Ljava/util/concurrent/Executor;
    .param p2, "webViewRenderProcessClient"    # Landroidx/webkit/WebViewRenderProcessClient;

    .line 159
    if-eqz p2, :cond_0

    .line 160
    new-instance v0, Landroidx/webkit/internal/WebViewRenderProcessClientAdapter;

    invoke-direct {v0, p1, p2}, Landroidx/webkit/internal/WebViewRenderProcessClientAdapter;-><init>(Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V

    invoke-static {v0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    goto :goto_0

    .line 162
    :cond_0
    const/4 v0, 0x0

    :goto_0
    nop

    .line 163
    .local v0, "handler":Ljava/lang/reflect/InvocationHandler;
    iget-object v1, p0, Landroidx/webkit/internal/WebViewProviderAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;

    invoke-interface {v1, v0}, Lorg/chromium/support_lib_boundary/WebViewProviderBoundaryInterface;->setWebViewRendererClient(Ljava/lang/reflect/InvocationHandler;)V

    .line 164
    return-void
.end method
