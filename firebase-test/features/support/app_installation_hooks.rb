require 'calabash-android/management/app_installation'

AfterConfiguration do |config|
  FeatureMemory.feature = nil
end

Before('@reinstall','~@en','~@hu') do |scenario|
  scenario = scenario.scenario_outline if scenario.respond_to?(:scenario_outline)

  feature = scenario.feature


  uninstall_apps
  install_app(ENV['TEST_APP_PATH'])
  install_app(ENV['APP_PATH'])
  FeatureMemory.feature = feature
  FeatureMemory.invocation = 1
end

Before('@same_app') do |scenario|
  scenario = scenario.scenario_outline if scenario.respond_to?(:scenario_outline)
  feature = scenario.feature
    FeatureMemory.feature = feature
    FeatureMemory.invocation = 1

  feature = scenario.feature
  FeatureMemory.invocation += 1
end

Before('@en') do |scenario|
  `adb shell '
  setprop persist.sys.language en;
  setprop persist.sys.country GB;
  stop;
  sleep 5;
  start'`
  sleep 5;

  scenario = scenario.scenario_outline if scenario.respond_to?(:scenario_outline)

  feature = scenario.feature


  uninstall_apps
  install_app(ENV['TEST_APP_PATH'])
  install_app(ENV['APP_PATH'])
  FeatureMemory.feature = feature
  FeatureMemory.invocation = 1
end

Before('@hu') do |scenario|
  `adb shell '
  setprop persist.sys.language hu;
  setprop persist.sys.country HU;
  stop;
  sleep 5;
  start'`
  sleep 5;

  scenario = scenario.scenario_outline if scenario.respond_to?(:scenario_outline)

  feature = scenario.feature


  uninstall_apps
  install_app(ENV['TEST_APP_PATH'])
  install_app(ENV['APP_PATH'])
  FeatureMemory.feature = feature
  FeatureMemory.invocation = 1
end


#Before do |scenario|
#  scenario = scenario.scenario_outline if scenario.respond_to?(:scenario_outline)
#
#  feature = scenario.feature
#  if FeatureMemory.feature != feature || ENV['RESET_BETWEEN_SCENARIOS'] == '1'
#    if ENV['RESET_BETWEEN_SCENARIOS'] == '1'
#      log 'New scenario - reinstalling apps'
#    else
#      log 'First scenario in feature - reinstalling apps'
#    end

#    uninstall_apps
#    install_app(ENV['TEST_APP_PATH'])
#    install_app(ENV['APP_PATH'])
#    FeatureMemory.feature = feature
#    FeatureMemory.invocation = 1
#  else
#    FeatureMemory.invocation += 1
#  end
#end

FeatureMemory = Struct.new(:feature, :invocation).new
