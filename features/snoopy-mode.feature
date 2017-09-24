Feature: Do Some things
  In order to do snoopy-things
  As a emacs user
  I want to do type on the digit row

  Scenario: Simple Snooping
    Given the buffer is empty
    When I turn on snoopy-mode
    And I type "!@#$%^&*()"
    Then I should see "1234567890"
    When  I turn off minor mode snoopy-mode
    And I type "!@#$%^&*()"
    Then I should see "!@#$%^&*()"
