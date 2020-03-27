class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, "public"   
        set :views, "app/views"
        enable :sessions
        set :session_secret, "meow"
    end

    get "/" do
        erb :index
    end

    get "/contact" do
        erb :contact
    end

    helpers do

        def login(email, password)
            user = User.find_by(email: email) 
            if user && user.authenticate(password) 
                session[:email] = user.email
            else
                redirect "/login"
            end
        end

        def current_user
            @current_user ||= User.find_by(email: session[:email]) if session[:email]
        end

        def login_employee(email, password)
           employee = Employee.find_by(email: email) 
           if employee && employee.authenticate(password) 
               session[:email] = employee.email
               employee.status = 1
               employee.save
           else
               redirect "/employee/login"
           end
       end

       def current_employee
           @current_employee ||= Employee.find_by(email: session[:email]) if session[:email]
       end

        def logged_in?
            !!current_user
        end

        def employee_logged_in?
            !!current_employee
        end

        def add_account
            if logged_in?
                "/account"
            end
        end

        def employee_logout!
          @current_employee = Employee.find_by(email: session[:email])
          ecid = @current_employee.cid
          if ecid != 0
            @chat_user = User.find_by(id: ecid)
            @chat_user.cid = 0
            @chat_user.save
            @current_employee.cid = 0
            @current_employee.messages = "Welcome to Live Chat!~"
          end
          @current_employee.status = -1
          @current_employee.save
          session.clear
          redirect "/"
        end

        def user_logout!
          @current_user = User.find_by(email: session[:email])
          @current_user.cid = 0
          @current_user.save
          session.clear
          redirect "/"
        end

        def format_str(str)
          strArr = str.strip.split(' ')
          s = ''
          strArr.each { |w| s += "#{w.capitalize} " }
          return s.strip
        end

        def add_user_detail_form
            "
            <br />
            <div id='usrfrm'>
            <p class='p_prof'>CLIENT<span> INFO</span></p>
            <div class='imgcontainer'>
                <img src='/img/usr-inf.png' alt='Avatar' class='avatar'>
            </div>
            <br />
            <br />
            <div class='container'>
                <label class='full_name' for='full_name'><b>Full name:</b></label>
                <input class='full_name' type='text' placeholder='Enter your first and last name...' name='full_name' required>
                <br />
                <br />
                <label class='dob' for='dob'><b>Date of birth:</b></label>
                <input class='dob' type='date' name='dob' required>
                <br />
                <br />
                <label class='gender' for='gender'><b>Gender:</b></label>
                <select name='gender' id='gender'>
                    <option value='Male' selected>&nbsp;</option>
                    <option value='Male'>Male</option>
                    <option value='Female'>Female</option>
                </select>
                <br />
                <br />
                <label class='address' for='address'><b>Address:</b></label>
                <input type='text' class='address' placeholder='Enter your address...' name='address' required>
                <br />
                <br />
                <label class='phone_number' for='phone_number'><b>Phone number:</b></label>
                <input class='phone_number' type='text' placeholder='Enter your phone number...' name='phone_number' required>

                <button id='nxtBtn' onclick='dispPetfrm()'>Next</button>
            <!--  <a href='javascript:void(0);'' onclick='dispPetfrm(); return false;'' id='nxtBtn'>Next</a> -->
            </div>
            </div>
            "
        end

        def pet_info_form
            "
            <div id='petfrm' style='z-index: 1; position: relative; top: 0px; display: none;'>
            <div class='imgcontainer'>
                <img src='/img/pet.jpg' alt='Avatar' class='avatar'>
            </div>
            <p class='p_prof'>PET <span>INFO</span></p>
            <br />
            <br />
            <div  />
                <label class='pet_name' for='pet_name'><b>Name:</b></label>
                <input class='pet_name' type='text' placeholder='Enter your pet&#39;s name here...' name='pet_name' required>
                <br />
                <br />
                <label class='pet_age' for='pet_age'><b>Age: &nbsp;</b></label>
                <input class='pet_age' type='text' placeholder='Enter your pet&#39;s age here...' name='pet_age'  required>
                <br />
                <br />
                <label class='gender' for='gender'><b>Gender:</b></label>
                <select name='pet_gender' id='pet-gender'  required>
                    <option value='Male' selected>Male</option>
                    <option value='Female'>Female</option>
                </select>
                <br />
                <br />
                <label class='address' for='address'><b>Breed:</b></label>
                <input type='text' class='address' placeholder='Enter your pet&#39;s breed here...' name='breed' required>
            <!--    <button id='prvBtn' onclick='dispUsrfrm(); ' style='position: relative; top: 0px;'>Previous</button> -->
                <!-- <a href='javascript:void(0);'' onclick='dispUsrfrm(); return false;'' id='prvBtn'>Previous</a> -->

            </div>
            </div>
            "
        end
    end
end
