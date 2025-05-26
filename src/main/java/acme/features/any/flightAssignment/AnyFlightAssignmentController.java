
package acme.features.any.flightAssignment;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;

import acme.client.components.principals.Any;
import acme.client.controllers.AbstractGuiController;
import acme.client.controllers.GuiController;
import acme.entities.flightAssignment.FlightAssignment;

@GuiController
public class AnyFlightAssignmentController extends AbstractGuiController<Any, FlightAssignment> {

	// Internal state ---------------------------------------------------------

	@Autowired
	private AnyAssignmentFlightListService	listService;

	@Autowired
	private AnyAssignmentFlightShowService	showService;

	// Constructors -----------------------------------------------------------


	@PostConstruct
	protected void initialise() {
		super.addBasicCommand("list", this.listService);
		super.addBasicCommand("show", this.showService);
	}

}
