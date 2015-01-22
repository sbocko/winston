package winston

class SvmResult extends AnalysisResult{
    public static final String KERNEL_LINEAR_KERNEL = "LinearKernel";
    public static final String KERNEL_RBF_KERNEL = "RBFKernel";

    String kernel;
    double complexityConstant;
    double gamma;

    public SvmResult(Analysis analysis, double rmse, String kernel, double complexityConstant, double gamma) {
        this.analysis = analysis
        this.rmse = rmse
        this.kernel = kernel
        this.complexityConstant = complexityConstant
        this.gamma = gamma
    }

    static constraints = {
    }
}
