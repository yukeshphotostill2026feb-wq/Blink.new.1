.class Lcom/blink/app/MainActivity$2$1;
.super Landroid/webkit/WebChromeClient;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blink/app/MainActivity$2;->onCreateWindow(Landroid/webkit/WebView;ZZLandroid/os/Message;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/blink/app/MainActivity$2;


# direct methods
.method constructor <init>(Lcom/blink/app/MainActivity$2;)V
    .locals 0
    .param p1, "this$1"    # Lcom/blink/app/MainActivity$2;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 184
    iput-object p1, p0, Lcom/blink/app/MainActivity$2$1;->this$1:Lcom/blink/app/MainActivity$2;

    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onCloseWindow(Landroid/webkit/WebView;)V
    .locals 1
    .param p1, "window"    # Landroid/webkit/WebView;

    .line 187
    iget-object v0, p0, Lcom/blink/app/MainActivity$2$1;->this$1:Lcom/blink/app/MainActivity$2;

    iget-object v0, v0, Lcom/blink/app/MainActivity$2;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/MainActivity;->-$$Nest$fgetwebView(Lcom/blink/app/MainActivity;)Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->removeView(Landroid/view/View;)V

    .line 188
    invoke-virtual {p1}, Landroid/webkit/WebView;->destroy()V

    .line 189
    return-void
.end method
