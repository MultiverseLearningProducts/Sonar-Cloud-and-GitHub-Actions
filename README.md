![logo](https://user-images.githubusercontent.com/44912347/206007212-1411a073-b11c-4a56-a36d-19d2dffe294f.jpg)

# Sonar Cloud and GitHub Actions CI
**GOAL**: Setup SonarCloud to run as a part of your GitHub Actions!

## Instructions
1. Fork this repository that contains an example Inventory App starter code from Bootcamp.
2. Navigate to SonarCloud dashboard and press the ✚ sign to analyze a new project.
3. Select the project that you forked from GitHub.
4. Select "GitHub Actions" as your analysis method

<img width="1148" alt="Screenshot 2022-12-06 at 2 16 34 PM" src="https://user-images.githubusercontent.com/44912347/206007653-3bedb8d9-a275-4e96-b30d-9954e3b82efe.png">

> The next steps may disappear on the initial setup as a report finishes. To access these if they disappear go to the following on the project page Admistration → Analysis Method → GitHub Actions Follow the Tutorial

5. In GitHub, copy and add the provided `SONAR_TOKEN` and value as a repository secret.

<img width="1115" alt="Screenshot 2022-12-06 at 2 16 41 PM" src="https://user-images.githubusercontent.com/44912347/206007986-3f82b49c-4b56-4dc6-aad8-8d2833e2b099.png">

6. Select "Other (for JS, TS, Go, Python, PHP, …)

<img width="1101" alt="Screenshot 2022-12-06 at 2 17 58 PM" src="https://user-images.githubusercontent.com/44912347/206008023-ffe4082d-b793-4c21-8a2e-0ace46418360.png">

7. Copy the provided code into your build.yml file. The code should look similar to the one shown below.
```yaml
name: Jest -> SonarCloud

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  sonarcloud:
    name: SonarCloud
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0  # Shallow clones should be disabled for a better relevancy of analysis
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # Needed to get PR information, if any
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

        #  These commands exist in the original file.
      - name: Install Dependencies
        run: npm i

      - name: Run tests
        run: npm run test
      
      # Add deployment commands here
```

8. Create a sonar-project.properties file in the root directory of the project. Copy the provided code.
9. Disable automatic analysis. 

<img width="1099" alt="Screenshot 2022-12-06 at 2 18 27 PM" src="https://user-images.githubusercontent.com/44912347/206008063-9472a5a2-4567-47f5-b860-343da965025c.png">

10. Save and push your changes and GitHub Actions will now run your analysis on SonarCloud.
