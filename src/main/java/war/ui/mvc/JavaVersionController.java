package war.ui.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.OutputStream;

/**
 * @author Quinten Krijger
 */
@Controller
@RequestMapping("/java")
public class JavaVersionController {

    @RequestMapping
    public ModelAndView javaVersion() throws IOException {
        ProcessBuilder processBuilder = new ProcessBuilder().command("java -version");
        Process start = processBuilder.start();
        try (OutputStream outputStream = start.getOutputStream()) {
            return new ModelAndView("messages/java", "process", outputStream.toString());
        }
    }

}
