import org.cloudbus.cloudsim.*;
import org.cloudbus.cloudsim.core.CloudSim;
import java.util.*;

public class TechMarketEscalonamento {
    public static void main(String[] args) throws Exception {
        int numUsers = 1;
        CloudSim.init(numUsers, Calendar.getInstance(), false);

        // Datacenter
        Datacenter datacenter = createDatacenter("Datacenter_TechMarket");

        // Criação do Broker
        DatacenterBroker broker = new DatacenterBroker("Broker_TechMarket");

        // Lista de VMs (Horizontal)
        List<Vm> vmlist = new ArrayList<>();
        for (int i = 0; i < 4; i++) {
            Vm vm = new Vm(i, broker.getId(), 1000, 2, 2048, 10000, 1000,
                    "Xen", new CloudletSchedulerTimeShared());
            vmlist.add(vm);
        }
        broker.submitVmList(vmlist);

        // Lista de Cloudlets (tarefas simuladas)
        List<Cloudlet> cloudletList = new ArrayList<>();
        UtilizationModel utilization = new UtilizationModelFull();
        for (int i = 0; i < 50; i++) {
            Cloudlet cloudlet = new Cloudlet(i, 40000, 1, 300, 300,
                    utilization, utilization, utilization);
            cloudlet.setUserId(broker.getId());
            cloudletList.add(cloudlet);
        }
        broker.submitCloudletList(cloudletList);

        // Iniciar simulação
        CloudSim.startSimulation();
        CloudSim.stopSimulation();

        // Resultados
        List<Cloudlet> resultList = broker.getCloudletReceivedList();
        double totalTime = 0;
        for (Cloudlet c : resultList) {
            totalTime += c.getActualCPUTime();
        }

        System.out.println("Tempo médio de execução: " + (totalTime / resultList.size()) + " ms");
        System.out.println("Total de Cloudlets processados: " + resultList.size());
    }

    private static Datacenter createDatacenter(String name) throws Exception {
        List<Host> hostList = new ArrayList<>();

        for (int i = 0; i < 4; i++) {
            List<Pe> peList = new ArrayList<>();
            peList.add(new Pe(0, new PeProvisionerSimple(1000)));
            hostList.add(new Host(i, new RamProvisionerSimple(16384),
                    new BwProvisionerSimple(10000), 1000000, peList,
                    new VmSchedulerSpaceShared(peList)));
        }

        return new Datacenter(name, new DatacenterCharacteristics(
                "x86", "Linux", "Xen", hostList, 10.0, 3.0, 0.05, 0.1, 0.1),
                new VmAllocationPolicySimple(hostList), new LinkedList<>(), 0);
    }
}
