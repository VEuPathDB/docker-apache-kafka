# Apache Kafka

A simple Docker image for Apache Kafka.

[On GitHub](https://github.com/Foxcapades/docker-apache-kafka)

## Usage

```bash
docker run -p 9092:9092 foxcapades/apache-kafka:3.4.0
```

## Configuration

### Environment

#### Container Config

The following options are provided as part of the Docker container and are not
part of Apache Kafka.

<table>
  <tr>
    <th>Option</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>KAFKA_SERVER_PROPERTIES_FILE</code></td>
    <td><code>string</code></td>
    <td><code>/opt/kafka/server.properties</code></td>
  </tr>
  <tr>
    <td><code>KAFKA_CLUSTER_ID</code></td>
    <td><code>string</code></td>
    <td><code>&lt;random uuid&gt;</code></td>
  </tr>
</table>

#### `server.properties`

All Kafka configuration options listed in the
[official documentation](https://kafka.apache.org/documentation/#brokerconfigs)
may be configured using environment variables.  The environment variable to set
for a specific option may be looked up in the
[server.properties.sh](https://github.com/Foxcapades/docker-apache-kafka/blob/3.4.0/server.properties.sh)
file, or by performing the following mapping steps:

1. Convert the property name to uppercase
2. Replace all period (`.`) characters with underscore (`_`) characters
3. Prepend the prefix `KAFKA_`

Property to Environment Mapping Snippet
```kotlin
fun mapPropertyNameToEnvironmentKey(property: String) =
  "KAFKA_" + property.uppercase().replace('.', '_')
```

#### Defaults

The following defaults are set if no environment variables are specified.

<table>
  <tr>
    <th>Property</th>
    <th>Default</th>
  </tr>

  <tr>
    <td><code>advertised.listeners</code></td>
    <td><code>PLAINTEXT://localhost:9092</code></td>
  </tr>
  <tr>
    <td><code>controller.listener.names</code></td>
    <td><code>CONTROLLER</code></td>
  </tr>
  <tr>
    <td><code>controller.quorum.voters</code></td>
    <td><code>1@localhost:9093</code></td>
  </tr>
  <tr>
    <td><code>inter.broker.listener.name</code></td>
    <td><code>PLAINTEXT</code></td>
  </tr>
  <tr>
    <td><code>listeners</code></td>
    <td><code>PLAINTEXT://:9092,CONTROLLER://:9093</code></td>
  </tr>
  <tr>
    <td><code>log.dirs</code></td>
    <td><code>/tmp/kafka</code></td>
  </tr>
  <tr>
    <td><code>node.id</code></td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>offsets.topic.replication.factor</code></td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>process.roles</code></td>
    <td><code>broker,controller</code></td>
  </tr>
  <tr>
    <td><code>transaction.state.log.min.isr</code></td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>transaction.state.log.replication.factor</code></td>
    <td><code>1</code></td>
  </tr>
</table>