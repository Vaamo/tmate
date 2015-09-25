# tmate cookbook

Installes a tmate-slave server on a node.

## Supported Platforms

 * Ubuntu

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tmate']['host']</tt></td>
    <td>String</td>
    <td>FQDN/IP to listen on</td>
    <td><tt>node['fqdn']</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['port']</tt></td>
    <td>String</td>
    <td>Port to listen on</td>
    <td><tt>2222</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['repo_url']</tt></td>
    <td>String</td>
    <td>Location of tmate-slave source</td>
    <td><tt>https://github.com/nviennot/tmate-slave.git</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['binary_name']</tt></td>
    <td>String</td>
    <td>Name of the binary after compiling</td>
    <td><tt>tmate-slave</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['username']</tt></td>
    <td>String</td>
    <td>User as whom we clone/compile tmate-slave</td>
    <td><tt>tmate</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['home_prefix']</tt></td>
    <td>String</td>
    <td>Prefix of home directory</td>
    <td><tt>/home</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['binary_dir']</tt></td>
    <td>String</td>
    <td>Location to where we install the tmate slave binary</td>
    <td><tt>/usr/local/bin</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['cfg_dir']</tt></td>
    <td>String</td>
    <td>Location to hold configuration and SSH keys</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['tmate']['log_dir']</tt></td>
    <td>String</td>
    <td>Location to hold logfiles</td>
    <td><tt>/var/log/tmate</tt></td>
  </tr>
</table>

## Usage

### tmate::default

Include `tmate` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[tmate::default]"
  ]
}
```

## License and Authors

Author:: Vaamo Finanz AG (<malte.krupa@vaamo.de>)
