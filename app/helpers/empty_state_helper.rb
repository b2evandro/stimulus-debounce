module EmptyStateHelper
    def empty_state(title: 'No record', subtitle: "Sorry, looks like we couldn't find any records to display", icon: 'signal-slash')
      render 'shared/empty_state', title:, subtitle:, icon:
    end
  end
  