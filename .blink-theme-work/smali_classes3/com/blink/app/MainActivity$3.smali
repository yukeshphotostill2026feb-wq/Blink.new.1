.class Lcom/blink/app/MainActivity$3;
.super Landroid/animation/AnimatorListenerAdapter;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/blink/app/MainActivity;->startSplashAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/blink/app/MainActivity;

.field final synthetic val$characters:[Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/blink/app/MainActivity;[Landroid/widget/TextView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/blink/app/MainActivity;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            null,
            null
        }
    .end annotation

    .line 530
    iput-object p1, p0, Lcom/blink/app/MainActivity$3;->this$0:Lcom/blink/app/MainActivity;

    iput-object p2, p0, Lcom/blink/app/MainActivity$3;->val$characters:[Landroid/widget/TextView;

    invoke-direct {p0}, Landroid/animation/AnimatorListenerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 3
    .param p1, "animation"    # Landroid/animation/Animator;

    .line 533
    iget-object v0, p0, Lcom/blink/app/MainActivity$3;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/MainActivity;->-$$Nest$fgetsplashOverlay(Lcom/blink/app/MainActivity;)Landroid/widget/FrameLayout;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 534
    :cond_0
    const/4 v0, 0x0

    .local v0, "index":I
    :goto_0
    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->val$characters:[Landroid/widget/TextView;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 535
    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->val$characters:[Landroid/widget/TextView;

    aget-object v1, v1, v0

    const-string v2, "BLINK"

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 536
    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->val$characters:[Landroid/widget/TextView;

    aget-object v1, v1, v0

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setAlpha(F)V

    .line 537
    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->val$characters:[Landroid/widget/TextView;

    aget-object v1, v1, v0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setScaleX(F)V

    .line 538
    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->val$characters:[Landroid/widget/TextView;

    aget-object v1, v1, v0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setScaleY(F)V

    .line 534
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 540
    .end local v0    # "index":I
    :cond_1
    iget-object v0, p0, Lcom/blink/app/MainActivity$3;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v0}, Lcom/blink/app/MainActivity;->-$$Nest$fgetsplashOverlay(Lcom/blink/app/MainActivity;)Landroid/widget/FrameLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 541
    .local v0, "parent":Landroid/view/ViewGroup;
    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->this$0:Lcom/blink/app/MainActivity;

    invoke-static {v1}, Lcom/blink/app/MainActivity;->-$$Nest$fgetsplashOverlay(Lcom/blink/app/MainActivity;)Landroid/widget/FrameLayout;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 542
    :cond_2
    iget-object v1, p0, Lcom/blink/app/MainActivity$3;->this$0:Lcom/blink/app/MainActivity;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/blink/app/MainActivity;->-$$Nest$fputsplashOverlay(Lcom/blink/app/MainActivity;Landroid/widget/FrameLayout;)V

    .line 543
    return-void
.end method
