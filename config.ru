require_relative "./config/environment"
require "./config/environment"




use Rack::MethodOverride
use ReviewController
use EmployeeController
use UsersController
use PetsController
use AppointmentsContoller
run ApplicationController
