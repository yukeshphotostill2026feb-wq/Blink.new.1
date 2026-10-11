.class Lcom/blink/app/MainActivity$2;
.super Landroid/webkit/WebChromeClient;
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

    .line 142
    iput-object p1, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreateWindow(Landroid/webkit/WebView;ZZLandroid/os/Message;)Z
    .locals 5
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "isDialog"    # Z
    .param p3, "isUserGesture"    # Z
    .param p4, "resultMsg"    # Landroid/os/Message;

    .line 178
    new-instance v0, Landroid/webkit/WebView;

    iget-object v1, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-direct {v0, v1}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    .line 179
    .local v0, "popup":Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 180
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 181
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v1

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setSupportMultipleWindows(Z)V

    .line 182
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v1

    invoke-virtual {v1, v0, v2}, Landroid/webkit/CookieManager;->setAcceptThirdPartyCookies(Landroid/webkit/WebView;Z)V

    .line 183
    const/4 v1, 0x6

    const/4 v3, 0x7

    const/4 v4, 0x5

    invoke-static {v4, v1, v3}, Landroid/graphics/Color;->rgb(III)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 184
    new-instance v1, Lcom/blink/app/MainActivity$2$1;

    invoke-direct {v1, p0}, Lcom/blink/app/MainActivity$2$1;-><init>(Lcom/blink/app/MainActivity$2;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 191
    new-instance v1, Lcom/blink/app/MainActivity$2$2;

    invoke-direct {v1, p0}, Lcom/blink/app/MainActivity$2$2;-><init>(Lcom/blink/app/MainActivity$2;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 202
    iget-object v1, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Lcom/blink/app/MainActivity;->-$$Nest$fgetwebView(Lcom/blink/app/MainActivity;)Landroid/webkit/WebView;

    move-result-object v1

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v3}, Landroid/webkit/WebView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 205
    iget-object v1, p4, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Landroid/webkit/WebView$WebViewTransport;

    .line 206
    .local v1, "transport":Landroid/webkit/WebView$WebViewTransport;
    invoke-virtual {v1, v0}, Landroid/webkit/WebView$WebViewTransport;->setWebView(Landroid/webkit/WebView;)V

    .line 207
    invoke-virtual {p4}, Landroid/os/Message;->sendToTarget()V

    .line 208
    return v2
.end method

.method public onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    .locals 9
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p3, "fileChooserParams"    # Landroid/webkit/WebChromeClient$FileChooserParams;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "Landroid/webkit/ValueCallback<",
            "[",
            "Landroid/net/Uri;",
            ">;",
            "Landroid/webkit/WebChromeClient$FileChooserParams;",
            ")Z"
        }
    .end annotation

    .line 149
    .local p2, "filePathCallback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<[Landroid/net/Uri;>;"
    iget-object v0, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/MainActivity;->-$$Nest$fgetpendingFileChooser(Lcom/blink/app/MainActivity;)Landroid/webkit/ValueCallback;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/MainActivity;->-$$Nest$fgetpendingFileChooser(Lcom/blink/app/MainActivity;)Landroid/webkit/ValueCallback;

    move-result-object v0

    invoke-interface {v0, v1}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 150
    :cond_0
    iget-object v0, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0, p2}, Lcom/blink/app/MainActivity;->-$$Nest$fputpendingFileChooser(Lcom/blink/app/MainActivity;Landroid/webkit/ValueCallback;)V

    .line 151
    iget-object v0, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/blink/app/MainActivity;->-$$Nest$fputpendingScheduleOcr(Lcom/blink/app/MainActivity;Z)V

    .line 152
    invoke-virtual {p3}, Landroid/webkit/WebChromeClient$FileChooserParams;->getAcceptTypes()[Ljava/lang/String;

    move-result-object v0

    array-length v3, v0

    move v4, v2

    :goto_0
    const/4 v5, 0x1

    if-ge v4, v3, :cond_2

    aget-object v6, v0, v4

    .line 153
    .local v6, "type":Ljava/lang/String;
    if-eqz v6, :cond_1

    invoke-virtual {v6}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v7

    const-string v8, "pdf"

    invoke-virtual {v7, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 154
    iget-object v7, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v7, v5}, Lcom/blink/app/MainActivity;->-$$Nest$fputpendingScheduleOcr(Lcom/blink/app/MainActivity;Z)V

    .line 152
    .end local v6    # "type":Ljava/lang/String;
    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 157
    :cond_2
    new-instance v0, Landroid/content/Intent;

    const-string v3, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 158
    const-string v3, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 159
    iget-object v3, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v3}, Lcom/blink/app/MainActivity;->-$$Nest$fgetpendingScheduleOcr(Lcom/blink/app/MainActivity;)Z

    move-result v3

    if-eqz v3, :cond_3

    const-string v3, "*/*"

    goto :goto_1

    :cond_3
    iget-object v3, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v3, p3}, Lcom/blink/app/MainActivity;->-$$Nest$macceptedPickerType(Lcom/blink/app/MainActivity;Landroid/webkit/WebChromeClient$FileChooserParams;)Ljava/lang/String;

    move-result-object v3

    :goto_1
    invoke-virtual {v0, v3}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 160
    .local v0, "picker":Landroid/content/Intent;
    iget-object v3, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v3}, Lcom/blink/app/MainActivity;->-$$Nest$fgetpendingScheduleOcr(Lcom/blink/app/MainActivity;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 161
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/String;

    const-string v4, "image/*"

    aput-object v4, v3, v2

    const-string v4, "application/pdf"

    aput-object v4, v3, v5

    const-string v4, "android.intent.extra.MIME_TYPES"

    invoke-virtual {v0, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;

    .line 163
    :cond_4
    invoke-virtual {p3}, Landroid/webkit/WebChromeClient$FileChooserParams;->getMode()I

    move-result v3

    if-ne v3, v5, :cond_5

    move v3, v5

    goto :goto_2

    :cond_5
    move v3, v2

    :goto_2
    const-string v4, "android.intent.extra.ALLOW_MULTIPLE"

    invoke-virtual {v0, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 165
    :try_start_0
    iget-object v3, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    const/16 v4, 0xe

    invoke-virtual {v3, v0, v4}, Lcom/blink/app/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 166
    return v5

    .line 167
    :catch_0
    move-exception v3

    .line 168
    .local v3, "error":Landroid/content/ActivityNotFoundException;
    const-string v4, "BLINK"

    const-string v5, "No document picker is available."

    invoke-static {v4, v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 169
    iget-object v4, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v4}, Lcom/blink/app/MainActivity;->-$$Nest$fgetpendingFileChooser(Lcom/blink/app/MainActivity;)Landroid/webkit/ValueCallback;

    move-result-object v4

    invoke-interface {v4, v1}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    .line 170
    iget-object v4, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v4, v1}, Lcom/blink/app/MainActivity;->-$$Nest$fputpendingFileChooser(Lcom/blink/app/MainActivity;Landroid/webkit/ValueCallback;)V

    .line 171
    iget-object v1, p0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v1, v2}, Lcom/blink/app/MainActivity;->-$$Nest$fputpendingScheduleOcr(Lcom/blink/app/MainActivity;Z)V

    .line 172
    return v2
.end method
