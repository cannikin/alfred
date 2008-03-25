module DashboardHelper

  def output_project_buttons(project)
    # get all info for current state
    state = State::STATES[project.state.name.downcase.to_sym]
    # for each :button in the state, build a button
    output_button(project,state[:button])
  end

  def output_button(project,button)
    output = '<input type="button" '
    button.stringify_keys.each do |key,value|
      output += key + '="' + value.gsub(/__id__/,project.id.to_s) + '" '
    end
    output += '/>'
  end

end
