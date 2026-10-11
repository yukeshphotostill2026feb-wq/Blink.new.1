.class public final Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;
.super Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbuf;
.source "com.google.mlkit:text-recognition-bundled-common@@17.0.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbvn;


# static fields
.field private static final zbb:Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;


# instance fields
.field private zbd:I

.field private zbe:I

.field private zbf:Ljava/lang/Object;

.field private zbg:Z

.field private zbh:Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbix;

.field private zbi:Z

.field private zbj:Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbhf;

.field private zbk:F

.field private zbl:Z

.field private zbm:Z

.field private zbn:I

.field private zbo:Z

.field private zbp:F

.field private zbq:I

.field private zbr:Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbbq;

.field private zbs:B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    invoke-direct {v0}, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;-><init>()V

    sput-object v0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbb:Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    const-class v1, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbuf;->zbD(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbuf;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbuf;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbe:I

    const/4 v0, 0x2

    iput-byte v0, p0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbs:B

    const/4 v0, -0x1

    iput v0, p0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbn:I

    return-void
.end method

.method static synthetic zba()Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;
    .locals 1

    sget-object v0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbb:Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    return-object v0
.end method


# virtual methods
.method protected final zbb(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 19

    .line 2
    move-object/from16 v0, p0

    add-int/lit8 v1, p1, -0x1

    const/4 v2, 0x0

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    if-nez p2, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    .line 1
    :pswitch_1
    sget-object v1, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbb:Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    return-object v1

    :pswitch_2
    new-instance v1, Lcom/google/android/libraries/vision/visionkit/pipeline/zbal;

    .line 3
    invoke-direct {v1, v2}, Lcom/google/android/libraries/vision/visionkit/pipeline/zbal;-><init>(Lcom/google/android/libraries/vision/visionkit/pipeline/zbak;)V

    return-object v1

    :pswitch_3
    new-instance v1, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    invoke-direct {v1}, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;-><init>()V

    return-object v1

    .line 2
    :pswitch_4
    const-class v5, Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbafq;

    const-string v17, "zbl"

    const-class v18, Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbcz;

    const-string v2, "zbf"

    const-string v3, "zbe"

    const-string v4, "zbd"

    const-string v6, "zbh"

    const-string v7, "zbj"

    const-string v8, "zbm"

    const-string v9, "zbn"

    const-string v10, "zbo"

    const-string v11, "zbg"

    const-string v12, "zbp"

    const-string v13, "zbq"

    const-string v14, "zbi"

    const-string v15, "zbr"

    const-string v16, "zbk"

    filled-new-array/range {v2 .. v18}, [Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbb:Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;

    const-string v3, "\u0004\u000e\u0001\u0001\u0001\u000e\u000e\u0000\u0000\u0001\u0001\u043c\u0000\u0002\u1009\u0001\u0003\u1009\u0003\u0004\u1007\u0006\u0005\u1004\u0007\u0006\u1007\u0008\u0007\u1007\u0000\u0008\u1001\t\t\u1004\n\n\u1007\u0002\u000b\u1009\u000b\u000c\u1001\u0004\r\u1007\u0005\u000e<\u0000"

    invoke-static {v2, v3, v1}, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbA(Lcom/google/android/gms/internal/mlkit_vision_text_bundled_common/zbvm;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    return-object v1

    :pswitch_5
    iget-byte v1, v0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbs:B

    .line 1
    invoke-static {v1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v1

    return-object v1

    .line 2
    :cond_0
    const/4 v1, 0x1

    :goto_0
    iput-byte v1, v0, Lcom/google/android/libraries/vision/visionkit/pipeline/zbam;->zbs:B

    return-object v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
