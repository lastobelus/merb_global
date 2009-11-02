# this is a separate file so we can control when the merb test controller gets defined

class TestBase
  include Merb::Global
  def inum
    return 42
  end
end


class TestHaml < Merb::Controller
  def inum
    return 47
  end

  def index
    render :index
  end
end
