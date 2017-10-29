module DriverSessionsHelper
    def log_in_driver(driver)
        session[:driver_id] = driver.id
        session["role"] = "driver"
    end
    
    def current_driver
        @current_driver ||= Driver.find_by(id: session[:driver_id])
    end
    
    def logged_in_driver?
        !current_driver.nil? && session["role"] == "driver"
    end
    
    def log_out_driver
        if logged_in_driver?
            forget(current_driver)
            session.delete(:driver_id)
            session.delete("role")
            @current_driver = nil
        end
    end
    
    def remember_driver(driver)
        driver.remember
        cookies.permanent.signed[:driver_id] = driver.id
        cookies.permanent[:remember_token] = driver.remember_token
    end
    
    def current_driver
        if (driver_id = session[:driver_id])
            @current_driver ||= Driver.find_by(id: driver_id)
        elsif (driver_id = cookies.signed[:driver_id])
            driver = Driver.find_by(id: driver_id)
            if driver && driver.authenticated?(cookies[:remember_token])
                log_in_driver driver
                @current_driver = driver
            end
        end
    end
    
    def forget_driver(driver)
        driver.forget
        cookies.delete(:driver_id)
        cookies.delete(:remember_token)
    end
end
