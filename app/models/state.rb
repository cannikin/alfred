class State < ActiveRecord::Base

  has_many :projects
  
  # in the code that builds the HTML for button, __id__ will be replaced by the project's id
  STATES = {  
              :stopped  => {  :id => State.find_by_name('Stopped').id,
                              :class => 'stopped',
                              :button => { :value => 'Start', :onclick => "project_blocks.start(__id__); return false;" }},
              :running  => {  :id => State.find_by_name('Running').id,
                              :class => 'running',
                              :button => { :value => 'Stop', :onclick => "project_blocks.stop(__id__); return false;" }},
              :error    => {  :id => State.find_by_name('Error').id,
                              :class => 'error',
                              :button => { :value => 'Restart', :onclick => "project_blocks.restart(__id__); return false;" }},
              :starting => {  :id => State.find_by_name('Starting').id,
                              :class => 'starting',
                              :button => { :value => 'Starting...', :disabled => 'disabled' }},
              :restart => {   :id => State.find_by_name('Restart').id,
                              :class => 'restart',
                              :button => { :value => 'Restart', :onclick => "project_blocks.restart(__id__); return false;" }}
           }



end
