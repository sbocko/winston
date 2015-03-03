package winston

class SvmResult extends AnalysisResult{
    public static final String KERNEL_LINEAR_KERNEL = "LinearKernel";
    public static final String KERNEL_RBF_KERNEL = "RBFKernel";

    String kernel;
    double complexityConstant;
    double gamma;

    public SvmResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, String kernel, double complexityConstant, double gamma) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.kernel = kernel
        this.complexityConstant = complexityConstant
        this.gamma = gamma
    }

    static constraints = {
    }

    @Override
    public String toString() {
        return "SvmResult{" +
                "id=" + id +
                ", kernel='" + kernel + '\'' +
                ", complexityConstant=" + complexityConstant +
                ", gamma=" + gamma +
                ", analysis=" + analysis +
                ", rmse=" + rmse +
                '}';
    }
}
