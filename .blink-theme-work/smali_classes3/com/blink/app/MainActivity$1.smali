.class Lcom/blink/app/MainActivity$1;
.super Landroid/webkit/WebViewClient;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blink/app/MainActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/blink/app/MainActivity;


# direct methods
.method constructor <init>(Lcom/blink/app/MainActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/blink/app/MainActivity;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 130
    iput-object p1, p0, Lcom/blink/app/MainActivity$1;->this$0:Lcom/blink/app/MainActivity;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;

    .line 133
    iget-object v0, p0, Lcom/blink/app/MainActivity$1;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/MainActivity;->-$$Nest$fgetassetLoader(Lcom/blink/app/MainActivity;)Landroidx/webkit/WebViewAssetLoader;

    move-result-object v0

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/webkit/WebViewAssetLoader;->shouldInterceptRequest(Landroid/net/Uri;)Landroid/webkit/WebResourceResponse;

    move-result-object v0

    return-object v0
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Z
    .locals 2
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;

    .line 138
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    .line 139
    .local v0, "uri":Landroid/net/Uri;
    iget-object v1, p0, Lcom/blink/app/MainActivity$1;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v1, v0}, Lcom/blink/app/MainActivity;->-$$Nest$misAllowedAppNavigation(Lcom/blink/app/MainActivity;Landroid/net/Uri;)Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    return v1
.end method
