import Link from "@docusaurus/Link";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import CodeBlock from "@theme/CodeBlock";
import Layout from "@theme/Layout";
import TabItem from "@theme/TabItem";
import Tabs from "@theme/Tabs";
import clsx from "clsx";
import {
	CheckCircle,
	Layers,
	MoveUpRight,
	RefreshCw,
	Settings,
	TrendingUp,
} from "lucide-react";
import type React from "react";

import styles from "./index.module.css";

export default function Home(): JSX.Element {
	const { siteConfig } = useDocusaurusContext();
	return (
		<Layout
			title={`${siteConfig.title}`}
			description="Description will go into a meta tag in <head />"
		>
			<div className={styles.home__container}>
				<header className={styles.home__headerContainer}>
					<section className={styles.home__hero}>
						<h1 className={styles.home__title}>{siteConfig.title}</h1>
						<div className={styles.home__tagline}>{siteConfig.tagline}</div>
						<div className={styles.home__buttonGroup}>
							<Link
								className={clsx(
									"button",
									styles.home__header__button,
									styles.primaryButton,
								)}
								to="/getting-started"
							>
								Get started
							</Link>
							<Link
								className={clsx(
									"button",
									styles.home__header__button,
									styles.secondaryButton,
								)}
								to="https://github.com/metacontract/mc/"
							>
								View on GitHub{" "}
								<MoveUpRight className={styles.externalLinkIcon} />
							</Link>
						</div>
					</section>
					<section className={styles.home__install}>
						<Tabs>
							<TabItem value="deployment" label="Deployment">
								<CodeBlock className="language-solidity">
									{`${siteConfig.customFields.deploymentCode}`}
								</CodeBlock>
							</TabItem>
							{/* <TabItem value="upgrade" label="Upgrade">
							<CodeBlock className="language-solidity">
								{`${siteConfig.customFields.upgradeCode}`}
							</CodeBlock>
						</TabItem> */}
						</Tabs>
					</section>
				</header>

				<main className={styles.home__main}>
					<article className={styles.article}>
						<h3 className={styles.article__title}>
							<RefreshCw className={styles.article__icon} />
							Upgradeability
						</h3>
						<p className={styles.article__description}>
							Meta Contracts can be upgraded without changing their address,
							allowing for seamless improvements and bug fixes.
						</p>
					</article>

					<article className={styles.article}>
						<h3 className={styles.article__title}>
							<Layers className={styles.article__icon} />
							Modularity
						</h3>
						<p className={styles.article__description}>
							The framework separates contract logic into distinct, manageable
							components, enhancing code organization and reusability.
						</p>
					</article>

					<article className={styles.article}>
						<h3 className={styles.article__title}>
							<TrendingUp className={styles.article__icon} />
							Scalability
						</h3>
						<p className={styles.article__description}>
							Meta Contracts are designed to handle growth efficiently, making
							them suitable for large-scale applications.
						</p>
					</article>

					<article className={styles.article}>
						<h3 className={styles.article__title}>
							<Settings className={styles.article__icon} />
							Flexibility
						</h3>
						<p className={styles.article__description}>
							Developers can easily extend and customize Meta Contracts to suit
							specific project needs.
						</p>
					</article>

					<article className={styles.article}>
						<h3 className={styles.article__title}>
							<CheckCircle className={styles.article__icon} />
							Testability
						</h3>
						<p className={styles.article__description}>
							The modular structure of Meta Contracts facilitates comprehensive
							testing, including unit tests for individual functions and
							integration tests for the entire system.
						</p>
					</article>
				</main>
			</div>
		</Layout>
	);
}
