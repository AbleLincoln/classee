module StudentsHelper
  def article_params
    params.require(:student).permit(:name, :major, :class1, :class2, :class3, :class4, :class5,)
  end
end
