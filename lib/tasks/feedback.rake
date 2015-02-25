
namespace :feedback do
  desc "Restart Application"
  task :remainder => [:environment] do
     OrderFeedback.feedback_remainder
  end
end