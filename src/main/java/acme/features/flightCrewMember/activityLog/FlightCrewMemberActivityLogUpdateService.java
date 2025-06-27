
package acme.features.flightCrewMember.activityLog;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import acme.client.components.models.Dataset;
import acme.client.helpers.MomentHelper;
import acme.client.helpers.PrincipalHelper;
import acme.client.services.AbstractGuiService;
import acme.client.services.GuiService;
import acme.entities.activityLog.ActivityLog;
import acme.realms.FlightCrewMember;

@GuiService
public class FlightCrewMemberActivityLogUpdateService extends AbstractGuiService<FlightCrewMember, ActivityLog> {

	// Internal state ---------------------------------------------------------

	@Autowired
	private FlightCrewMemberActivityLogRepository repository;

	// AbstractGuiService interface -------------------------------------------


	@Override
	public void authorise() {
		boolean status;
		int activityLogId = super.getRequest().getData("id", int.class);
		ActivityLog activityLog = this.repository.findActivityLogById(activityLogId);
		status = activityLog != null && activityLog.isDraftMode() && activityLog.getAssignment().getMember().getId() == super.getRequest().getPrincipal().getActiveRealm().getId();

		super.getResponse().setAuthorised(status);
	}

	@Override
	public void load() {
		ActivityLog activityLog;
		int id;

		id = super.getRequest().getData("id", int.class);
		activityLog = this.repository.findActivityLogById(id);

		super.getBuffer().addData(activityLog);
	}

	@Override
	public void bind(final ActivityLog object) {
		assert object != null;

		super.bindObject(object, "moment", "logType", "description", "severityLevel");
	}

	@Override
	public void validate(final ActivityLog object) {
		if (object.getMoment() != null) {
			Date dateFlightAssignment = this.repository.findFlightAssignmentById(object.getAssignment().getId()).getLastUpdate();
			boolean correctMoments = object.getMoment().after(dateFlightAssignment);
			super.state(correctMoments, "*", "acme.validation.activityLog.moment");
		}
		/*
		 * if (object.getAssignment() != null) {
		 * boolean correctAssign = object.getAssignment().getStatus().equals(Status.LANDED);
		 * super.state(!correctAssign, "assignment", "acme.validation.activityLog.assign");
		 * }
		 */
		assert object != null;
	}

	@Override
	public void perform(final ActivityLog object) {
		object.setMoment(MomentHelper.getCurrentMoment());
		this.repository.save(object);
	}

	@Override
	public void onSuccess() {
		if (super.getRequest().getMethod().equals("POST"))
			PrincipalHelper.handleUpdate();
	}

	@Override
	public void unbind(final ActivityLog object) {

		Dataset dataset;

		dataset = super.unbindObject(object, "moment", "logType", "description", "severityLevel", "draftMode");
		super.getResponse().addData(dataset);
	}

}
