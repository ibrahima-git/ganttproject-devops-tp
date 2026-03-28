# Stage 1: Build
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

COPY gradlew .
COPY gradle/ gradle/
COPY build.gradle .
COPY settings.gradle .
COPY ganttproject/ ganttproject/
COPY biz.ganttproject.core/ biz.ganttproject.core/
COPY biz.ganttproject.app.libs/ biz.ganttproject.app.libs/
COPY biz.ganttproject.app.localization/ biz.ganttproject.app.localization/
COPY ganttproject-builder/ ganttproject-builder/
COPY ganttproject-tester/ ganttproject-tester/
COPY biz.ganttproject.impex.ical/ biz.ganttproject.impex.ical/
COPY biz.ganttproject.impex.msproject2/ biz.ganttproject.impex.msproject2/
COPY biz.ganttproject.mxgraph/ biz.ganttproject.mxgraph/
COPY org.ganttproject.chart.pert/ org.ganttproject.chart.pert/
COPY org.ganttproject.impex.htmlpdf/ org.ganttproject.impex.htmlpdf/

RUN chmod +x gradlew && ./gradlew :ganttproject-builder:build -x test -x compileKotlin --no-daemon

# Stage 2: Runtime
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/ganttproject-builder/dist-bin/ .

LABEL maintainer="ibrahima-git"
LABEL version="3.4"
LABEL description="GanttProject - DevOps TP"

EXPOSE 8080

CMD ["java", "-jar", "ganttproject.jar"]