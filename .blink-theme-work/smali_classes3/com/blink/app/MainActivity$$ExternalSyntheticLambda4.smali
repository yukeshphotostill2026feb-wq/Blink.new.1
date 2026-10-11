.class public final synthetic Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/google/android/gms/tasks/OnSuccessListener;


# instance fields
.field public final synthetic f$0:Lcom/blink/app/MainActivity;

.field public final synthetic f$1:Lcom/google/mlkit/vision/text/TextRecognizer;


# direct methods
.method public synthetic constructor <init>(Lcom/blink/app/MainActivity;Lcom/google/mlkit/vision/text/TextRecognizer;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;->f$0:Lcom/blink/app/MainActivity;

    iput-object p2, p0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;->f$1:Lcom/google/mlkit/vision/text/TextRecognizer;

    return-void
.end method


# virtual methods
.method public final onSuccess(Ljava/lang/Object;)V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;->f$0:Lcom/blink/app/MainActivity;

    iget-object v1, p0, Lcom/blink/app/MainActivity$$ExternalSyntheticLambda4;->f$1:Lcom/google/mlkit/vision/text/TextRecognizer;

    check-cast p1, Lcom/google/mlkit/vision/text/Text;

    invoke-static {v0, v1, p1}, Lcom/blink/app/MainActivity;->$r8$lambda$OcAAF5DPCCAto4avMx9IaniOdI4(Lcom/blink/app/MainActivity;Lcom/google/mlkit/vision/text/TextRecognizer;Lcom/google/mlkit/vision/text/Text;)V

    return-void
.end method
