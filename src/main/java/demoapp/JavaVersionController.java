package demoapp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * @author Quinten Krijger
 * @author Frank Scholten
 */
@Controller
@RequestMapping("/")
public class JavaVersionController {

  @RequestMapping
  public ModelAndView javaVersion() throws IOException {
    ProcessBuilder processBuilder = new ProcessBuilder().command("/usr/bin/java", "-version");
    processBuilder.redirectErrorStream(true);

    String javaVersion = parseJavaVersion(processBuilder);

    return new ModelAndView("java", "javaVersion", javaVersion);
  }

  private String parseJavaVersion(ProcessBuilder processBuilder) throws IOException {
    String javaVersion;
    try {
      Process process = processBuilder.start();
      InputStream inputStream = process.getInputStream();

      int exitStatus = process.waitFor();

      if (exitStatus != 0) {
        javaVersion = "The Java process exited with status code: " + exitStatus;
      } else {
        BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
        javaVersion = br.readLine();
      }
    } catch (InterruptedException e) {
      javaVersion = "Could not start Java process: " + e.getCause().getMessage();
    }
    return javaVersion;
  }

}
