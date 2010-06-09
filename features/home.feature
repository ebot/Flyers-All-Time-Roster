Feature: View Jersey Numbers

  Scenario: Home page
    Given I am viewing "/"
    Then I should see "By Jersey Number"
    And I should see "ACTON"
    And I should see "ZUBRUS"
    And I should see "<h2>1</h2>"
    And I should see "<h2>97</h2>"